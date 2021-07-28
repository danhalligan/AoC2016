$num = IO.read('inputs/q13.txt').to_i

def wall?(p)
  x, y = p
  ans = x*x + 3*x + 2*x*y + y + y*y + $num
  ans.to_s(2).split('').count('1') % 2 == 1
end

def neighbours(p)
  x, y = p
  [[x-1, y], [x, y-1], [x+1, y], [x, y+1]].
    select{|p| p[0] >= 0 and p[1] >= 0}.
    select {|p| !wall?(p)}
end

queue, discard = {}, {}
queue[[1,1]] =  {dist: 0, from: nil}
target = [31,39]

while queue.length > 0
  c = queue.keys.first
  cd = queue[c][:dist]
  discard[c] = queue.delete(c)

  neighbours(c).
    select {|x| !discard.key? x}.
    each {|x|
      if !queue.key?(x) or (queue.key?(x) and cd + 1 < queue[x][:dist])
        queue[x] = {dist: cd + 1, from: c}
      end
    }
end

puts "Part1: #{discard[target][:dist]}"
puts "Part1: #{discard.select{|k,v| v[:dist] <= 50}.length}"

# show route!

# route = [target]
# route.unshift(discard[route[0]][:from]) while route[0] != [1,1]
# maxx = discard.map{|k,v| k[0]}.max
# maxy = discard.map{|k,v| k[1]}.max
# pic = (0..maxy).map {|y|
#   (0..maxx).map {|x|
#     c = wall?([x,y]) ? '▓▓▓' : '   '
#     route.include?([x,y]) ? ' o ' : c
#   }.join("")
# }.join("\n")
# puts pic

