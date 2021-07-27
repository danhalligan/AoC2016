inst = IO.readlines('inputs/q10.txt', chomp: true)

dat = {
  'bot' => Hash.new { |hash, key| hash[key] = [] },
  'output' => Hash.new { |hash, key| hash[key] = [] },
}

comp = {}
i = 0
while inst.length > 0
  line = inst[i]
  if line =~ /^value/
    a, b = line.scan(/\d+/).map(&:to_i)
    dat['bot'][b] += [a]
    inst.delete_at(i)
    i = 0
  elsif line =~ /^bot/
    na, nb, nc = line.scan(/\d+/).map(&:to_i)
    ta, tb, tc = line.scan(/\w+\s\d+/).map {|x| x.gsub(/\s.+$/, '')}
    if dat[ta][na].length >= 2
      low, high = dat[ta][na].sort
      comp[[low, high]] = na
      dat[tb][nb] += [dat[ta][na].delete(low)]
      dat[tc][nc] += [dat[ta][na].delete(high)]
      inst.delete_at(i)
      i = 0
    else
      i += 1
    end
  end
end

puts "Part1: #{comp[[17, 61]]}"

prod = dat['output'][0][0] * dat['output'][1][0] * dat['output'][2][0]
puts "Part2: #{prod}"
