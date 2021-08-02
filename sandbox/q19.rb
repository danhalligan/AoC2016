inp = IO.read('inputs/q19.txt').to_i

# require './circle.rb'
# 2.upto(100) do |num|
#   x = Circle.new([1]*num)
#   while true
#     break if x.value == num
#     n = x.next
#     n = x.next(n) while n.value == 0
#     x.value += n.value
#     n.value = 0
#     x.move
#     x.move while x.value == 0
#   end
#   puts "#{num} #{x.num}"
# end

# Just working out the pattern...
# val = 1
# 2.upto(3014387) do |num|
#   val += 2
#   val = 1 if val > num
# end
# puts "Part1: #{val}"

# OR
def part1(n)
  pwr = 2**Math.log(n, 2).floor
  (n - pwr)*2 + 1
end
puts "Part1: #{part1(n)}"

# OR
# https://www.youtube.com/watch?v=uCsD3ZGzMgE
# puts "Part1: #{(inp.to_s(2)[2..] + '1').to_i(2)}"

# def part2(n)
#   x = (1..n).to_a
#   p = 0
#   while x.length > 1
#     v = x[p]
#     n = x.length
#     x.delete_at((p + n/2) % n)
#     p = (x.find_index(v) + 1) % x.length
#   end
#   x[0]
# end

# Hopelessly slow
# puts "Part2: #{part2(3014387)}"

# Try to spot pattern
# 2.upto(500) do |n|
#   puts "#{n} #{part2(n)}"
# end

# Again spot the pattern (powers of 3)
# after previous highest power of 3 (pwr), we count up by 1 to pwr, then count by 2
def part2(n)
  pwr = 3**Math.log(n, 3).floor
  count = n - pwr
  count <= pwr ? count : pwr + (count - pwr)*2
end
puts "Part2: #{part2(inp)}"




