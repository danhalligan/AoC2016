$num = IO.read('inputs/q13.txt', chomp: true).to_i

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

x = [1,1]
queue, discard = [], {}
queue.push({pos:x, dist:0})
target = [31,39]
best = 10000
while true
  c = queue.sort! {|x, y| x[:dist] <=> y[:dist] }.shift
  break c if c[:pos] == target
  discard[c[:pos]] = c[:dist]
  neighbours(c[:pos]).
    select {|x| !discard.key? x}.
    each {|x| queue.push({pos:x, dist:c[:dist]+1})}
end

puts "Part1: #{c[:dist]}"

