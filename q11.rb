require "deep_clone"

def chips(x)
  x.select{|x| x.match(/.M/)}
end

def rtgs(x)
  x.select{|x| x.match(/.G/)}
end

def rtg2chip(x)
  x.sub(/G$/, 'M')
end

def valid_arrangement(dat)
  (0..3).each do |floor|
    items = dat[floor]
    if chips(items).length > 0 and rtgs(items).length > 0
      mychips = chips(items)
      rtgs(items).each {|g| mychips.delete(rtg2chip(g)) }
    end
  end
  return true
end

def stringify(dat, floor)
  (0..3).map { |floor| dat[floor].sort.join('')}.join('|') + '|' + floor.to_s
end

def directions(n)
  {0 => [1], 1 => [1, -1], 2 => [1, -1], 3 => [-1]}[n]
end

def score(dat)
  (0..3).map {|i| dat[i].length * (i+1) }.sum
end

def read_data(file = 'inputs/q11.txt')
  IO.readlines(file, chomp: true).map do |line|
    gens = line.scan(/(\w+)\sgenerator/).map{|x| x[0][0].capitalize + 'G'}
    chips = line.scan(/(\w+)-compatible\smicrochip/).map{|x| x[0][0].capitalize + 'M'}
    gens + chips
  end
end

def neighbours(dat, floor, dist)
  movable = [1,2].map { |items| dat[floor].combination(items).to_a }.flatten(1)
  dirs = directions(floor)
  options = movable.product(dirs).map do |x|
    new_dat = DeepClone.clone(dat)
    new_floor = floor + x[1]
    new_dat[new_floor] += x[0].each { |x| new_dat[floor].delete(x) }
    {dat: new_dat, floor: new_floor, score: score(new_dat), dist: dist+1}
  end
end

def find_best(dat)
  queue, discard, floor = [], {}, 0
  queue.push({dat: dat, floor: floor, dist: 0, score: score(dat)})
  target = dat.flatten.length * 4
  while true
    c = queue.sort! {|x, y| y[:score] <=> x[:score] }.shift
    return c if c[:score] == target
    discard[stringify(c[:dat], c[:floor])] = c
    neighbours(c[:dat], c[:floor], c[:dist]).
      select {|x| !discard.key? stringify(x[:dat], x[:floor])}.
      each {|x| queue.push(x)}
  end
end


dat = read_data()
puts "Part1: #{find_best(dat)[:dist]}"

dat[0] += ['EG', 'EM', 'DG', 'DM']
puts "Part2: #{find_best(dat)[:dist]}"
