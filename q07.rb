dat = IO.readlines("inputs/q07.txt", chomp: true)

def tls?(x)
  r1 = x.split(/\[\w+?\]/).any? {|s| s.match? /(\w)(?!\1)(\w)\2\1/}
  r2 = x.scan(/\[(\w+?)\]/).any? {|s| s[0].match? /(\w)(?!\1)(\w)\2\1/ }
  r1 and !r2
end

puts "Part1: #{dat.count {|x| tls?(x)}}"


def ssl?(x)
  abas = x.split(/\[\w+?\]/).map {|s| s.scan /(?=(\w)(?!\1)(\w)\1)/}.flatten(1)
  return false unless abas.length

  abas.any? do |m|
    x.scan(/\[(\w+?)\]/).any? {|s| s[0].match? /#{m[1]+m[0]+m[1]}/ }
  end
end

dat = IO.readlines("inputs/q07.txt", chomp: true)
dat.count {|x| ssl?(x)}
