dat = IO.readlines("inputs/q06.txt", chomp: true).
  map {|x| x.split('')}.
  transpose

res = dat.map {|x| x.tally.max_by{|k,v| v}[0] }
puts "Part1: #{res.join()}"

res = dat.map {|x| x.tally.min_by{|k,v| v}[0] }
puts "Part2: #{res.join()}"
