txt = IO.read("inputs/q01.txt")
d, x, y = 0, 0, 0

txt.split(", ").map do |move|
  n = move[1..].to_i
  d = (move[0] == "R" ? d + 1 : d - 1) % 4
  case d
  when 0 then y += n
  when 1 then x += n
  when 2 then y -= n
  when 3 then x -= n
  end
end
puts "Part1: #{x.abs + y.abs}"


# part b
d, x, y = 0, 0, 0
visit = Hash.new {|h, k| h[k] = 0}
txt.split(", ").map do |move|
  n = move[1..].to_i
  d = (move[0] == "R" ? d + 1 : d - 1) % 4
  for i in 1..n
    case d
    when 0 then y += 1
    when 1 then x += 1
    when 2 then y -= 1
    when 3 then x -= 1
    end
    # puts "#{x}, #{y}"
    visit[x.to_s + ":" + y.to_s] += 1
    break if visit[x.to_s + ":" + y.to_s] == 2
  end
  break if visit.select {|k,v| v == 2}.length >= 1
end

twice = visit.select {|k,v| v == 2}.first[0]
result = twice.split(':').map(&:to_i).map(&:abs).reduce(&:+)
puts "Part2: #{result}"
