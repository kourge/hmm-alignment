load 'hmm.rb' unless defined?(HMM)

if ARGV.empty?
  STDERR.puts "Usage: ruby #{__FILE__} hw2.muscle organism/*.faa"
  exit -1
end

DEBUG = !!ENV['DEBUG']

if RUBY_PLATFORM != 'java' || ENV['LINEAR']
  warn 'using linear (sequential) mode' if DEBUG

  def best_scoring(hmm, proteins)
    best_score = -Float::INFINITY
    best_vmatrix = nil
    best_protein = nil

    proteins.each do |protein|
      warn "#{protein.size}#{protein.metadata}" if DEBUG
      v = hmm.viterbi(protein)
      $protein_count -= 1 if $protein_count
      warn "    #{$protein_count} left, score=#{v[1]}, protein=#{protein.metadata}" if DEBUG
      if v[1] > best_score
        best_vmatrix, best_score = v
        best_protein = protein
      end
    end
    warn "best found, score=#{best_score}, protein=#{best_protein.metadata}" if DEBUG

    path = hmm.viterbi_path(best_vmatrix, best_protein)
    warn "path length=#{path.size}" if DEBUG

    {:score => best_score, :protein => best_protein, :path => path}
  end
else
  warn 'using parallelized (peach) mode' if DEBUG

  require 'peach'
  CORES = 4

  def best_scoring(hmm, proteins)
    best_score = -Float::INFINITY
    best_protein = nil
    best_vmatrix = nil
    proteins.each_slice(CORES * 4).each do |slice|
      v = best_scoring_parallel(hmm, slice)
      if v[0] > best_score
        best_score, best_protein, best_vmatrix = v
      end
    end

    warn "best found, score=#{best_score}, protein=#{best_protein.metadata}" if DEBUG

    path = hmm.viterbi_path(best_vmatrix, best_protein)
    warn "path length=#{path.size}" if DEBUG

    {:score => best_score, :protein => best_protein, :path => path}
  end

  def best_scoring_parallel(hmm, proteins)
    proteins.pmap do |protein|
      warn "#{protein.size}#{protein.metadata}" if DEBUG
      v = hmm.viterbi(protein)
      $protein_count -= 1 if $protein_count
      warn "    #{$protein_count} left, score=#{v[1]}, protein=#{protein.metadata}" if DEBUG
      [v[1], protein, v[0]]
    end.max_by { |(score, protein, matrix)| score }
  end
end

muscle = Muscle.open(ARGV.first)
warn 'multiple alignment loaded' if DEBUG

proteins = ARGV[1..-1].map { |file| Protein.open(file) }.flatten
$protein_count = proteins.size
warn "#{$protein_count} proteins loaded" if DEBUG

limit = ENV['limit']
proteins = proteins[0...limit.to_i] if limit
warn "LIMIT detected, truncating to #{limit.to_i} proteins" if limit && DEBUG

force_protein = ENV['PROTEIN']
proteins = proteins.find_all { |p| p == force_protein } if force_protein
warn "PROTEIN override detected, protein = #{force_protein}" if force_protein && DEBUG

background_frequency = Protein.background_frequency(proteins)
warn 'background frequency = %p' % [background_frequency] if DEBUG

hmm = HMM.new(muscle, background_frequency)
warn 'HMM trained' if DEBUG

proteins.sort! { |a, b| a.size <=> b.size }
result = best_scoring(hmm, proteins)

new_muscle, new_match_states = hmm.realign(result[:path])
warn 'realignment completed' if DEBUG

emission = hmm.emit(result[:protein], result[:path], new_muscle, new_match_states)
species = ENV['SPECIES'] || 'Unknown_species'
new_muscle.rows[species] = emission
new_muscle.order << species

if ENV['MY_NAME']
  puts ENV['MY_NAME']
  puts
end

puts result[:protein].metadata
puts '[protein description]'
puts "#{result[:score]}"
puts result[:path].join(',')
puts '[explanation]'
puts new_muscle.pp(6)

