def find_start(dat)
  0.step do |start|
    return start if dat.each_with_index.all? {|t, i|
      (dat[i][:p] + i+start+1) % dat[i][:n] == 0
    }
  end
end

dat = IO.readlines('inputs/q15.txt', chomp: true).map {|x|
  x =~ /Disc #(\d+) has (\d+) positions; at time=(\d+), it is at position (\d+)/
  {n: $2.to_i, p: $4.to_i}
}

puts "Part1: #{find_start(dat)}"

dat.push({n: 11, p: 0})
puts "Part2: #{find_start(dat)}"
