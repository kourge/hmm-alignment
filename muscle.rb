require 'stringio'

class Muscle
  def self.open(filename)
    ignore_header_lines = 3
    order = nil
    result = nil
    buffer = []

    File.open(filename).each_line do |line|
      if ignore_header_lines != 0
        ignore_header_lines -= 1
        next
      end

      if line != "\n"
        buffer << line
      else
        parse = self.parse_run(buffer)

        if result.nil?
          result = parse
          order = result.delete(:order)
        else
          result.delete(:order)
          result.keys.each do |k|
            result[k] << parse[k]
          end
        end
        buffer = []
      end
    end

    if not buffer.empty?
      parse = self.parse_run(buffer)

      if result.nil?
        result = parse
        order = result.delete(:order)
      else
        result.delete(:order)
        result.keys.each do |k|
          result[k] << parse[k]
        end
      end
      buffer = []
    end

    marks = result.delete(:marks)
    self.new(result, order, marks)
  end

  RUN_FORMAT = /([a-zA-Z_.]+?)\s+(.+)\n/

  def self.parse_run(buffer)
    offset = 0
    length = 0
    order = []
    result = {}

    buffer[0..-2].each do |line|
      m = line.match(RUN_FORMAT)

      offset = m.offset(2)[0]
      length = m[2].size
      result[m[1]] = m[2]
      order << m[1]
    end

    result[:marks] = buffer.last[offset..-2]
    result[:order] = order
    result
  end

  attr_reader :rows, :marks, :order, :size
  alias :length :size

  def initialize(rows, order, marks=[])
    @rows = rows
    @order = order
    @marks = marks
    @size = @rows.values.first.size
  end

  def inspect
    "<#{self.class} size=#{self.size}>"
  end

  def pp(spacing=3)
    out = StringIO.new

    padding = self.rows.keys.map(&:length).max + spacing
    self.rows.each do |name, row|
      out.puts name.ljust(padding) + row
    end

    out.string
  end
end
