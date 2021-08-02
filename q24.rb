require 'deep_clone'

class Ducts
  attr_reader :data, :locs

  def self.from_file(file = 'inputs/q24.txt')
    data = IO.readlines(file, chomp: true).map do |line|
      line.split('')
    end
    self.new(data)
  end

  def initialize(data)
    @data = data

    @walls = {}
    data.each_with_index{|r, i| r.each_with_index {|c, j| @walls[[i,j]] = c.match? /#/}}

    @locs = {}
    data.each_with_index{|r, i| r.each_with_index {|c, j| @locs[c] = [i,j] if c.match? /(\d)/ }}
    @maxdist = 1000000
  end

  def wall?(pos)
    @walls[pos]
  end

  def adjacent(p)
    [[p[0]-1,p[1]], [p[0]+1,p[1]], [p[0],p[1]-1], [p[0],p[1]+1]]
  end

  def neighbours(p)
    adjacent(p).select {|x| !wall?(x) }
  end

  def newpath
    path = {}
    @data.each_with_index{|r, i| r.each_with_index {|c, j|
      path[[i,j]] = @maxdist unless c.match?(/#/)
    }}
    path
  end

  def tovisit
    @locs.select {|x| x != "0"}.keys
  end

  def find_path(s, e)
    path = newpath
    queue = [@locs[s]]
    path[@locs[s]] = 0
    mindist = @maxdist

    while queue.length > 0
      c = queue.shift
      mindist = path[c] if c == @locs[e]
      next if path[c] > mindist
      neighbours(c).each do |n|
        if path[n] > path[c] + 1
          path[n] = path[c] + 1
          queue.append(n)
        end
      end
    end
    mindist
  end

  # pairwise distances
  def dists
    @dists ||= @locs.keys.combination(2).map {|f, t|
      [[f,t].sort, find_path(f, t)]
    }.to_h
  end

  def route_dist(route)
    route.reduce(0) { |sum, section| sum + dists[section.sort] }
  end
end

x = Ducts.from_file()

# find min with
part1 = x.tovisit.permutation.map {|o|
  route = (["0"] + o[0..-2]).zip(o)
  x.route_dist(route)
}.min
puts "Part1: #{part1}"

part2 = x.tovisit.permutation.map {|o|
  route = (["0"] + o).zip(o + ["0"])
  x.route_dist(route)
}.min
puts "Part2: #{part2}"
