require 'colorize'
class Grid
  attr_accessor :nodes, :dist, :max_x, :max_y, :goalpos

  def self.from_file(file = 'inputs/q22.txt')
    inp =  IO.readlines(file, chomp: true).drop(1)
    head = inp.shift
    dat = {}
    inp.each do |x|
      x = x.split()
      x[0] =~ /node-x(\d+)-y(\d+)/
      dat[[$1.to_i, $2.to_i]] = {used: x[2].to_i, avail: x[3].to_i}
    end
    self.new(dat, 0,)
  end

  def initialize(data, dist)
    @nodes = data
    @dist = dist
    @max_x = @nodes.keys.map {|x,y| x}.max
    @max_y = @nodes.keys.map {|x,y| y}.max
    @goalpos = [max_x, 0]
  end

  def empty
    nodes.select{|k,v| v[:used] == 0}.keys.first
  end

  # available pairs of nodes?
  def available
    @nodes.to_a.permutation(2).
      select {|a, b| a[1][:used] > 0 and a[1][:used] < b[1][:avail]}.
      map {|a, b| [a[0], b[0]]}.
      to_h
  end

  def block?(p)
    nodes[p][:used] > 400
  end

  def sym(p)
    case
    when p == @goalpos then 'G'.blue
    when block?(p) then '█'.red
    when p == empty then '●'.blue
    else '.'
    end
  end

  def print
    str = (0..max_y).map {|y| (0..max_x).map {|x| sym([x,y])}.join(' ')}
    puts str
  end
end


dat = Grid.from_file('inputs/q22.txt')
puts "Part1: #{dat.available.length}"

dat.print

lx = 38
bstart = dat.nodes.keys.select{|p| dat.block?(p)}.map{|x,y|x}.min
x, y = dat.empty
moves = x - bstart + 1 + y + (lx-bstart) + (lx-1)*5 + 1
puts "Part2: #{moves}"
