require 'digest'

def open?(path)
  h = Digest::MD5.hexdigest($code+path)
  o = h[0..3].split('').map {|x| ('b'..'f').to_a.include? x}
  ['U', 'D', 'L', 'R'].zip(o).to_h
end

def neighbours(p, path = '')
  x, y = p
  is_open = open?(path)
  {'U'=>[x, y-1], 'D'=>[x, y+1], 'L'=>[x-1, y], 'R'=>[x+1, y]}.
    select {|k, v| is_open[k]}.
    select {|k, v| v[0] >= 0 and v[1] >= 0}.
    select {|k, v| v[0] <= 3 and v[1] <= 3}
end

def find_min_path(loc, target, path)
  return path if loc == target
  neighbours(loc, path).
    map {|k, v| find_min_path(v, target, path+k)}.
    compact.min_by(&:length)
end

def find_max_dist(loc, target, path)
  return path.length if loc == target
  neighbours(loc, path).
    map {|k, v| find_max_dist(v, target, path+k)}.
    map(&:to_i).max
end

$code = IO.read('inputs/q17.txt').chomp

puts "Part1: #{find_min_path([0,0], [3,3], '')}"
puts "Part2: #{find_max_dist([0,0], [3,3], '')}"
