def part1(inp, max)
  n = 0
  while n <= max
    inc = inp.select {|x, y| (n >= x and n <= y) }
    if inc.length > 0
      n = inc.first[1] + 1
    else
      break
    end
  end
  n
end

def part2(inp, max)
  n = 0
  count = 0
  while n <= max
    inc = inp.select {|x, y| (n >= x and n <= y) }
    if inc.length > 0
      n = inc.first[1] + 1
    else
      count += 1
      n += 1
    end
  end
  count
end

inp = IO.readlines('inputs/q20.txt', chomp: true).
  map {|x| x.split('-').map(&:to_i) }

puts "Part1: #{part1(inp, 4294967295)}"
puts "Part2: #{part2(inp, 4294967295)}"
