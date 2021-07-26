dat = IO.readlines("inputs/q04.txt", chomp: true).map do |x|
  x = x.split('-')
  id, checksum = x[-1].match(/(\d+)\[(\w+)\]/).captures
  {id: id.to_i, checksum: checksum, dat: x[0..-2]}
end

real = dat.select do |x|
  tab = x[:dat].join.split('').tally.sort_by {|k, v| [-v, k]}.to_h
  tab.keys.join.start_with? x[:checksum]
end

puts "Part1: #{real.sum{|x| x[:id]}}"


def shift_letters(str, n)
  letters = ('a'..'z').to_a
  convert = letters.zip((n..(n+26)).to_a.map {|i| letters[i % 26]}).to_h
  str.split('').map {|x| convert[x]}.join()
end

results = real.map { |x|
  text = x[:dat].map {|s| shift_letters(s, x[:id])}.join(" ")
  {text: text, id: x[:id]}
}.select { |x|
  x[:text].match?('north')
}

puts "Part2: #{results.first[:id]}"
