load 'protein.rb' unless defined?(Protein)
load 'muscle.rb' unless defined?(Muscle)

class HMM
  class State
    attr_accessor :type, :number
    def self.[](*args, &blk) self.new(*args, &blk) end
    def initialize(type, number) @type, @number = type, number end
    def hash()
      return @hash if @hash
      @hash = @number * 3 + {:D => 0, :I => 1, :M => 2}[@type]
    end
    def to_i() self.hash end
    def eql?(other) self.type == other.type && self.number == other.number end
    def ==(other) self.eql?(other) end
    def ===(other) self.eql?(other) end
    def <=>(other) self.hash <=> other.hash end
    def to_s() "#{@type}_#{@number}" end
    def inspect() "'#{self.to_s}'" end
  end

  GAP = '-'
  STAR = '*'

  I_0 = State[:I, 0]
  M_0 = State[:M, 0]
  M_1 = State[:M, 1]
  D_0 = State[:D, 0]
  D_1 = State[:D, 1]


  def initialize(muscle, background_frequency={}, threshold=6)
    @muscle = muscle
    @threshold = threshold
    @background_frequency = background_frequency

    self.match_states
    self.emission_p
    self.transition_p
  end

  def match_states
    return @match_states if @match_states

    @match_states = []
    cols = @muscle.rows.values
    (0...@muscle.size).each do |i|
      gaps = cols.count { |col| col[i] == GAP }
      @match_states << i if gaps <= @threshold
    end
    @match_states
  end

  def emissions
    return @emissions if @emissions

    @emissions = {}
    (0..match_states.size).each do |i|
      @emissions[State[:M, i]] = Hash.new(0)
      @emissions[State[:I, i]] = Hash.new(0)
    end

    @muscle.rows.each do |key, row|
      state = 0
      (0...row.size).each do |i|
        c = row[i]

        if state < self.match_states.size && i == self.match_states[state]
          state += 1
          next if c == GAP
          c = 'A' unless Protein::AMINO_ACIDS.include?(c)
          @emissions[State[:M, state]][c] += 1
        else
          next if c == GAP
          c = 'A' unless Protein::AMINO_ACIDS.include?(c)
          @emissions[State[:I, state]][c] += 1
        end
      end
    end
    @emissions
  end

  def emission_p
    return @emission_p if @emission_p

    pseudocounts = Hash.new { |h, v| h[v] = {} }
    emissions.each do |state, emission|
      @background_frequency.each do |protein, frequency|
        pseudocount = @background_frequency[protein]
        pseudocount += emission[protein] if emission.include?(protein)
        pseudocounts[state][protein] = pseudocount
      end
    end

    @emission_p = Hash.new { |h, v| h[v] = {} }
    pseudocounts.each do |state, pseudocount|
      total = 0
      pseudocount.each do |protein, frequency|
        total += frequency
      end
      pseudocount.each do |protein, frequency|
        @emission_p[state][protein] = frequency.to_f / total
      end
    end
    @emission_p
  end

  def transitions
    return @transitions if @transitions

    @transitions = {
      M_0 => { I_0 => 0, M_1 => 0, D_1 => 0 },
      I_0 => { I_0 => 0, M_1 => 0, D_1 => 0 }
    }

    (1...match_states.size).each do |i|
      @transitions[State[:I, i]] = {
        State[:I, i] => 0, State[:M, i + 1] => 0, State[:D, i + 1] => 0
      }
      @transitions[State[:M, i]] = {
        State[:I, i] => 0, State[:M, i + 1] => 0, State[:D, i + 1] => 0
      }
      @transitions[State[:D, i]] = {
        State[:I, i] => 0, State[:M, i + 1] => 0, State[:D, i + 1] => 0
      }
    end

    last_state = match_states.size
    end_state = last_state + 1
    @transitions[State[:I, last_state]] = {
      State[:I, last_state] => 0, State[:M, end_state] => 0
    }
    @transitions[State[:M, last_state]] = {
      State[:I, last_state] => 0, State[:M, end_state] => 0
    }
    @transitions[State[:D, last_state]] = {
      State[:I, last_state] => 0, State[:M, end_state] => 0
    }

    @muscle.rows.each do |key, row|
      match = 0
      prev_state = M_0

      (0...row.size).each do |i|
        if match < match_states.size && i == match_states[match]
          match += 1
          next_state = State[(row[i] == GAP ? :D : :M), match]
          @transitions[prev_state][next_state] += 1
          prev_state = next_state
        else
          unless row[i] == GAP
            next_state = State[:I, match]
            @transitions[prev_state][next_state] += 1
            prev_state = next_state
          end
        end
      end

      match += 1
      next_state = State[:M, match]
      @transitions[prev_state][next_state] += 1
    end
    @transitions
  end

  D_BEGIN_TO_M_D = 0.1
  D_BEGIN_TO_O_D = 0.45
  D_LASTD_TO_ENDD = 0.9
  D_LASTD_TO_O_D = 0.1
  D_LASTO_TO_ENDD = 0.1
  D_LASTO_TO_O_D = 0.9
  D_SAME_D = 0.9
  D_DIFF_D = 0.05

  def transition_p
    return @transition_p if @transition_p

    last_state = match_states.size
    pseudocounts = Hash.new { |k, v| k[v] = {} }

    transitions.each do |state, next_states|
      next_states.each do |next_state, count|
        pseudocount = case state
          when State[:I, last_state], State[:M, last_state]
            next_state.type == :M ? D_LASTO_TO_ENDD : D_LASTO_TO_O_D
          when M_0
            next_state.type == :M ? D_BEGIN_TO_M_D : D_BEGIN_TO_O_D
          when State[:D, last_state]
            next_state.type == :M ? D_LASTD_TO_ENDD : D_LASTD_TO_O_D
          else state.type == next_state.type ? D_SAME_D : D_DIFF_D
        end

        pseudocounts[state][next_state] = count + pseudocount
      end
    end

    @transition_p = Hash.new { |k, v| k[v] = {} }
    pseudocounts.each do |state, next_states|
      total = 0
      next_states.each do |next_state, count|
        total += count
      end
      next_states.each do |next_state, count|
        @transition_p[state][next_state] = count.to_f / total
      end
    end

    @transition_p
  end

  # sequence is a Protein
  def viterbi(sequence)
    v = {State[:M, match_states.size + 1] => Array.new(sequence.size + 1, 0)}

    transition_p.each do |state, next_states|
      (0..sequence.size).each do |i|
        v[state] = Array.new(sequence.size + 1, 0)
      end
    end

    (0..sequence.size).each do |i|
      (0..(match_states.size + 1)).each do |j|
        prev_i, prev_m, prev_d = State[:I, j - 1], State[:M, j - 1], State[:D, j - 1]
        curr_i, curr_m, curr_d = State[:I, j], State[:M, j], State[:D, j]

        if i == 0
          v[curr_m][i] = curr_m == M_0 ? 0 : -Float::INFINITY
          next if j == match_states.size + 1

          v[curr_i][i] = -Float::INFINITY
          next if j == 0

          v[curr_d][i] = if curr_d == D_1
            [
              Math.log2(transition_p[prev_i][curr_d]),
              Math.log2(transition_p[prev_m][curr_d])
            ].max
          else
            [
              v[prev_i][i] + Math.log2(transition_p[prev_i][curr_d]),
              v[prev_m][i] + Math.log2(transition_p[prev_m][curr_d]),
              v[prev_d][i] + Math.log2(transition_p[prev_d][curr_d])
            ].max
          end
        else
          c = sequence[i - 1]
          c = 'A' unless Protein::AMINO_ACIDS.include?(c)

          i_emission_log = Math.log2(
            emission_p[curr_i][c].to_f / @background_frequency[c]
          )
          case curr_i
            when I_0
              v[curr_i][i] = i_emission_log + [
                v[curr_i][i - 1] + Math.log2(transition_p[curr_i][curr_i]),
                v[curr_m][i - 1] + Math.log2(transition_p[curr_m][curr_i])
              ].max
            when State[:I, match_states.size + 1]
              #
            else
              v[curr_i][i] = i_emission_log + [
                v[curr_i][i - 1] + Math.log2(transition_p[curr_i][curr_i]),
                v[curr_m][i - 1] + Math.log2(transition_p[curr_m][curr_i]),
                v[curr_d][i - 1] + Math.log2(transition_p[curr_d][curr_i])
              ].max
          end

          m_emission_log = Math.log2(
            emission_p[curr_m][c].to_f / @background_frequency[c]
          )
          v[curr_m][i] = case curr_m
            when M_0
              -Float::INFINITY
            when M_1
              m_emission_log + [
                v[prev_i][i - 1] + Math.log2(transition_p[prev_i][curr_m]),
                v[prev_m][i - 1] + Math.log2(transition_p[prev_m][curr_m])
              ].max
            when State[:M, match_states.size + 1]
              [
                v[prev_i][i] + Math.log2(transition_p[prev_i][curr_m]),
                v[prev_m][i] + Math.log2(transition_p[prev_m][curr_m]),
                v[prev_d][i] + Math.log2(transition_p[prev_d][curr_m])
              ].max
            else
              m_emission_log + [
                v[prev_i][i - 1] + Math.log2(transition_p[prev_i][curr_m]),
                v[prev_m][i - 1] + Math.log2(transition_p[prev_m][curr_m]),
                v[prev_d][i - 1] + Math.log2(transition_p[prev_d][curr_m])
              ].max
          end

          case curr_d
            when D_1
              v[curr_d][i] = [
                v[prev_i][i] + Math.log2(transition_p[prev_i][curr_d]),
                v[prev_m][i] + Math.log2(transition_p[prev_m][curr_d])
              ].max
            when D_0
              #
            when State[:D, match_states.size + 1]
              #
            else
              v[curr_d][i] = [
                v[prev_i][i] + Math.log2(transition_p[prev_i][curr_d]),
                v[prev_m][i] + Math.log2(transition_p[prev_m][curr_d]),
                v[prev_d][i] + Math.log2(transition_p[prev_d][curr_d])
              ].max
          end
        end
      end
    end

    [v, v[State[:M, match_states.size + 1]].last]
  end

  def viterbi_path(v, sequence)
    begin_state = M_0
    curr_state = State[:M, match_states.size + 1]
    curr_col = sequence.size

    path = [curr_state]
    until curr_state == begin_state
      curr_num = curr_state.number
      prev_num = curr_num - 1
      prev_col = curr_col - 1
      curr_i, curr_m, curr_d = State[:I, curr_num], State[:M, curr_num], State[:D, curr_num]
      prev_i, prev_m, prev_d = State[:I, prev_num], State[:M, prev_num], State[:D, prev_num]

      if curr_state.type == :I
        i_score = v[curr_i][prev_col] + Math.log2(transition_p[curr_i][curr_state])
        m_score = v[curr_m][prev_col] + Math.log2(transition_p[curr_m][curr_state])
        curr_col = prev_col

        if curr_state.number == 0
          case [i_score, m_score].max
          when i_score
            path << curr_i
            curr_state = curr_i
          when m_score
            path << curr_m
            curr_state = curr_m
          end
        else
          d_score = v[curr_d][prev_col] + Math.log2(transition_p[curr_d][curr_state])

          case [i_score, m_score, d_score].max
          when i_score
            path << curr_i
            curr_state = curr_i
          when m_score
            path << curr_m
            curr_state = curr_m
          when d_score
            path << curr_d
            curr_state = curr_d
          end
        end
      elsif curr_state.type == :D || curr_state.number == match_states.size + 1
        i_score = v[prev_i][curr_col] + Math.log2(transition_p[prev_i][curr_state])
        m_score = v[prev_m][curr_col] + Math.log2(transition_p[prev_m][curr_state])

        if curr_state.number == 1
          case [i_score, m_score].max
          when i_score
            path << prev_i
            curr_state = prev_i
          when m_score
            path << prev_m
            curr_state = prev_m
          end
        else
          d_score = v[prev_d][curr_col] + Math.log2(transition_p[prev_d][curr_state])

          case [i_score, m_score, d_score].max
          when i_score
            path << prev_i
            curr_state = prev_i
          when m_score
            path << prev_m
            curr_state = prev_m
          when d_score
            path << prev_d
            curr_state = prev_d
          end
        end
      elsif curr_state.type == :M
        i_score = v[prev_i][prev_col] + Math.log2(transition_p[prev_i][curr_state])
        m_score = v[prev_m][prev_col] + Math.log2(transition_p[prev_m][curr_state])
        curr_col = prev_col

        if curr_state.number == 1
          case [i_score, m_score].max
          when i_score
            path << prev_i
            curr_state = prev_i
          when m_score
            path << prev_m
            curr_state = prev_m
          end
        else
          d_score = v[prev_d][prev_col] + Math.log2(transition_p[prev_d][curr_state])

          case [i_score, m_score, d_score].max
          when i_score
            path << prev_i
            curr_state = prev_i
          when m_score
            path << prev_m
            curr_state = prev_m
          when d_score
            path << prev_d
            curr_state = prev_d
          end
        end
      end
    end

    path.reverse!
    path
  end

  def realign(path)
    match_i = 0
    new_match_states = []
    new_muscle_rows = {}

    @muscle.rows.each do |key, row|
      emission = ""
      row_i, match_i = 0, 0
      counter = 0

      path[1..-2].each do |state|
        if state.type == :M || state.type == :D
          while row_i != match_states[match_i]
            emission << row[row_i]
            row_i += 1
            counter += 1
          end if match_i < match_states.size

          new_match_states << counter
          emission << row[row_i]

          row_i += 1
          match_i += 1
        else
          if row_i >= row.size || match_i < match_states.size &&
             row_i == match_states[match_i]
            emission << GAP
          else
            emission << row[row_i]
            row_i += 1
          end
        end
        counter += 1
      end

      while row_i < row.size
        emission << row[row_i]
        row_i += 1
      end

      new_muscle_rows[key] = emission
    end

    [Muscle.new(new_muscle_rows, @muscle.order), new_match_states]
  end

  def emit(protein, path, muscle, new_match_states)
    emission = ""
    row_i, match_i = 0, 0
    counter = 0
    path[1..-2].each do |state|
      case state.type
      when :I
        emission << protein[row_i]
        row_i += 1
      when :D
        while counter < new_match_states[match_i]
          emission << GAP
          counter += 1
        end if match_i < new_match_states.size
        emission << GAP
        match_i += 1
      when :M
        while counter < new_match_states[match_i]
          emission << GAP
          counter += 1
        end if match_i < new_match_states.size
        emission << protein[row_i]
        row_i += 1
        match_i += 1
      end
      counter += 1
    end

    while row_i < protein.size
      emission << protein[row_i]
      row_i += 1
      counter += 1
    end
    while counter < muscle.size
      emission << GAP
      counter += 1
    end

    emission
  end
end
