require 'deep_clone'
require 'set'

class State
  attr_accessor :config, :floor, :dist

  def initialize(data, floor = 0, dist = 0)
    @config = data
    @floor = floor
    @dist = 0
  end

  def score
    (0..3).map {|f| items(f).length * (f+1) }.sum
  end

  def stringify
    (0..3).map {|f| items(f).sort.join('')}.join('|') + '|' + @floor.to_s
  end

  def items(f = @floor)
    @config[f]
  end

  # which objects can be moved from our current floor?
  # don't leave unmatched microchips
  def movable
    [1,2].map {|n| items.combination(n).to_a }.flatten(1)
  end

  # what directions can the elevator move in?
  # don't move things back down to empty floors!
  def directions
    dirs = {0 => [1], 1 => [1, -1], 2 => [1, -1], 3 => [-1]}[@floor]
    dirs = [1] if @floor == 1 and @config[0].length == 0
    dirs = [1] if @floor == 2 and @config[1].length == 0 and @config[0].length == 0
    dirs
  end

  # return possible new states from current
  # don't move items if it leaves a floor invalid
  # don't move 1 up if you can move 2 up
  # don't move 2 down if you can move 1 down
  def neighbours
    set = movable.product(directions).select { |x|
      valid_floor(Set.new(items) - Set.new(x)) or
      valid_floor(Set.new(items(x[1])) + Set.new(x[0]))
    }
    twoup = set.any? {|x| x[1] == 1 and x[0].length == 2}
    set = set.reject {|x| x[1] == 1 and x[0].length == 1} if twoup
    onedn = set.any? {|x| x[1] == -1 and x[0].length == 1}
    set = set.reject {|x| x[1] == -1 and x[0].length == 2} if onedn

    set.map {|x|
      nb = self.clone
      nb.floor += x[1]
      nb.dist += 1
      nb.config[nb.floor] += x[0].each {|x| nb.config[floor].delete(x)}
      nb
    }
  end

  def valid_floor(items)
    chips = Set.new(items.select{|x| x.match(/.M/)})
    rtgs = Set.new(items.select{|x| x.match(/.G/)}.map{|x| rtg2chip(x.dup)})
    return false if chips.length > 0 and rtgs.length > 0 and (chips-rtgs).length > 0
    return true
  end

  def chips(floor)
    @config[floor].select{|x| x.match(/.M/)}
  end

  def rtgs(floor)
    @config[floor].select{|x| x.match(/.G/)}
  end

  def rtg2chip(x)
    x[1] = 'M'
    x
  end

  def clone
    DeepClone.clone(self)
  end

  def target
    @config.flatten.length * 4
  end
end


def read_data(file = 'inputs/q11.txt')
  IO.readlines(file, chomp: true).map do |line|
    gens = line.scan(/(\w+)\sgenerator/).map{|x| x[0][0].capitalize + 'G'}
    chips = line.scan(/(\w+)-compatible\smicrochip/).map{|x| x[0][0].capitalize + 'M'}
    gens + chips
  end
end

def find_best(x)
  queue, discard = [], {}
  queue.push(x)
  target = x.target
  best = x.score
  while true
    c = queue.sort! {|x, y| y.score <=> x.score }.shift
    return c if c.score == target
    if c.score > best
      # puts "Score: #{c.score}, Dist: #{c.dist}"
      best = c.score
    end
    discard[c.stringify] = true
    c.neighbours.
      select {|x| !discard.key? x.stringify}.
      each {|x| queue.push(x)}
  end
end

x = State.new(read_data())
puts "Part1: #{find_best(x).dist}"

x.config[0] += ['EG', 'EM', 'DG', 'DM']
puts "Part2: #{find_best(x).dist}"
