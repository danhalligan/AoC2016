inp = IO.read('inputs/q19.txt').to_i

def part1(n)
  pwr = 2**Math.log(n, 2).floor
  (n - pwr)*2 + 1
end
puts "Part1: #{part1(inp)}"

def part2(n)
  pwr = 3**Math.log(n, 3).floor
  x = n - pwr
  x <= pwr ? x : pwr + (x - pwr)*2
end
puts "Part2: #{part2(inp)}"
