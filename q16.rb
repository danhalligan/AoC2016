def generate(x, target)
  while true
    x = x + '0' + x.reverse.tr('10', '01')
    return x[..target-1] if x.length > target
  end
end

def checksum(x)
  while true
    x = x.gsub(/../) {|m| {'11'=>'1', '00'=>'1', '01'=>'0', '10'=>'0'}[m] }
    return x if x.length % 2 == 1
  end
end

dat = IO.read('inputs/q16.txt').chomp
puts "Part1: #{checksum(generate(dat, 272))}"
puts "Part2: #{checksum(generate(dat, 35651584))}"
