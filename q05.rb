require 'digest'

input = IO.read("inputs/q05.txt").chomp
i = 0
pass = ''
while pass.length < 8
  h = Digest::MD5.hexdigest input + i.to_s
  pass += h[5] if h.match?(/^00000/)
  i += 1
end

puts "Part1: #{pass}"


i = 0
pass = ['_']*8
while pass.count("_") > 0
  h = Digest::MD5.hexdigest input + i.to_s
  if h.match?(/^00000/) and h[5].match?(/\d/) and h[5].to_i <= 7 and pass[h[5].to_i] == '_'
    pass[h[5].to_i] = h[6]
    print '    ', pass.join(' '), "\r"
  end
  i += 1
end
puts
puts "Part2: #{pass.join()}"
