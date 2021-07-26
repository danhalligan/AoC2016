dat = IO.readlines("inputs/q03.txt", chomp: true).
  map{|x| x.split.map(&:to_i)}

is_triangle = ->(x) do
  x = x.sort()
  x[0..1].sum > x[2]
end

valid = dat.count(&is_triangle)
puts "Part1: #{valid}"

valid = dat.each_slice(3).sum {|x| x.transpose.count(&is_triangle)}
puts "Part2: #{valid}"
