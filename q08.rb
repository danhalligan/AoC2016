dat = IO.readlines("inputs/q08.txt", chomp: true)

screen = Array.new(6) { Array.new(50) {false} }
dat.each do |line|
  a, b = line.scan(/\d+/).map(&:to_i)
  if line.match? /rect/
    b.times {|r| a.times {|c| screen[r][c] = true }}
  elsif line.match? /column/
    s = screen.transpose
    s[a].rotate!(-b)
    screen = s.transpose
  elsif line.match? /row/
    screen[a].rotate!(-b)
  end
end

puts "Part1: #{screen.flatten.count(true)}"

puts "Part2:"
puts screen.map {|r| r.map {|c| c ? '█' : ' ' }.join }
