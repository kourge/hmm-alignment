
class M
  if RUBY_PLATFORM == 'java'
    def initialize(rows, cols)
      @a = Java::int[rows * cols].new
      @rows = rows
      @cols = cols
    end
  else
    def initialize(rows, cols)
      @a = Array.new(rows * cols, 0)
      @rows = rows
      @cols = cols
    end
  end

  def [](i, j)
    @a[i * @cols + j]
  end

  def []=(i, j, v)
    @a[i * @cols + j] = v
  end

  def each_with_index
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        yield self[i, j], i, j
      end
    end
=begin
    i = 0
    while i < @rows
      j = 0
      while j < @cols
        yield self[i, j], i, j
        j += 1
      end
      i += 1
    end
    self
=end
  end
end


class Protein < String
  EMPTY = self.new('-')
  AMINO_ACIDS = %w(A R N D C E Q G H I L K M F P S T W Y V)

  def self.open(file)
    replicon = File.basename(file).sub(/\..+$/, '')
    proteins = []
    buffer = []
    IO.readlines(file).each do |line|
      if line =~ /^>/
        proteins << self.parse(buffer.join(''), replicon) unless buffer.empty?
        buffer = [line]
      else
        buffer << line
      end
    end
    proteins
  end

  def self.parse(data, replicon=nil)
    i = data =~ /\n/
    self.new(data[i..-1]).tap do |p|
      p.metadata = data[0..i]
      p.replicon = replicon
    end
  end

  def self.[](*args, &blk)
    self.new(*args, &blk)
  end

  def self.background_frequency(proteins)
    counts = Hash.new(0)
    total = 0

    proteins.each do |protein|
      protein.each_char do |c|
        c = 'A' unless AMINO_ACIDS.include?(c)
        counts[c] += 1
        total += 1
      end
    end

    counts.keys.each do |k|
      counts[k] = counts[k].to_f / total
    end
    counts
  end

  attr_reader :metadata, :pid, :name
  attr_accessor :replicon

  def initialize(*args, &blk)
    super
    self.gsub!("\n", "")
  end

  def metadata=(metadata)
    @metadata = metadata.strip
    _, pid, _, _, name = metadata.split('|')
    @pid = pid.to_i
    @name = name.strip
  end

  def inspect
    # "#{self.class.name}[#{super}]"
    super
  end

  module Scoring
    LECTURE = lambda { |x, y| x == y ? 2 : -1 }
  end

  Alignment = Struct.new(:repr, :range)

  def Alignment.hsla_matrix(one, other, scoring)
    m = M.new(one.size + 1, other.size + 1)
    max, max_val = [0, 0], 0

    m.each_with_index do |_, i, j|
      next if i == 0 || j == 0
      v = [
        0,
        m[i - 1, j - 1] + scoring[one[i - 1], other[j - 1]],
        m[i - 1, j] + scoring[one[i - 1], EMPTY],
        m[i, j - 1] + scoring[EMPTY, other[j - 1]]
      ].max
      m[i, j] = v
      max, max_val = [i, j], v if v > max_val
    end

    [m, max, max_val]
  end

  def Alignment.hsla_alignment(one, other, scoring, m, max, max_val)
    i, j, v = *max, max_val
    s, s_start, s_end = [], 0, Float::INFINITY
    t, t_start, t_end = [], 0, Float::INFINITY
    while v != 0
      case v
      when m[i - 1, j - 1] + scoring[one[i - 1], other[j - 1]]
        s << one[i - 1]
        t << other[j - 1]

        s_end, t_end = i - 1, j - 1 if [i, j] == max
        s_start, t_start = i - 1, j - 1

        i, j = i - 1, j - 1
      when m[i - 1, j] + scoring[one[i - 1], EMPTY]
        s << one[i - 1]
        t << EMPTY

        s_start, t_start = i - 1, j

        i, j = i - 1, j
      when m[i, j - 1] + scoring[EMPTY, other[j - 1]]
        s << EMPTY
        t << other[j - 1]

        s_start, t_start = i, j - 1

        i, j = i, j - 1
      end

      v = m[i, j]
    end

    [
      self.new(s.join.reverse, (s_start..s_end)),
      self.new(t.join.reverse, (t_start..t_end))
    ]
  end

  def Alignment.diff(a, b, scoring)
    diff = ''
    x, y = a[:repr], b[:repr]
    (0...x.size).each do |i|
      if x[i] == y[i]
        diff << x[i]
      elsif scoring[x[i], y[i]] > 0
        diff << '+'
      else
        diff << ' '
      end
    end

    diff
  end
end

load 'blosum62-table.rb'

