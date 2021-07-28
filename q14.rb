require 'digest'

$salt = IO.read('inputs/q14.txt').chomp

def md5hash(i)
  Digest::MD5.hexdigest $salt + i.to_s
end

def stretched_hash(i)
  h = md5hash(i)
  2016.times { h = Digest::MD5.hexdigest(h) }
  h
end

def find_index(index)
  stack = (0..999).map {|i| yield(i) }
  i = 0
  count = 1
  while true
    h = stack.shift
    stack.push yield(i+1000)
    if h =~ /(\w)\1{2}/ and stack.any? {|x| x[$1*5]}
      # puts "#{i} #{count}"
      return i if count == index
      count += 1
    end
    i += 1
  end
end

puts "Part1: #{find_index(64) {|i| md5hash(i)}}"
puts "Part2: #{find_index(64) {|i| stretched_hash(i)}}"
