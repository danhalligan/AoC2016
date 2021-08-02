
def scramble(pass, inp)
  inp.each do |line|
    if line =~ /swap position (\d+) with position (\d+)/
      pass[$1.to_i], pass[$2.to_i] = pass[$2.to_i], pass[$1.to_i]
    elsif line =~ /swap letter (\w+) with letter (\w+)/
      pass.tr!($1+$2, $2+$1)
    elsif line =~ /rotate right (\d+) step/
      pass = pass.split('').rotate(-$1.to_i).join()
    elsif line =~ /rotate left (\d+) step/
      pass = pass.split('').rotate($1.to_i).join()
    elsif line =~ /rotate based on position of letter (\w)/
      p = pass.split('')
      i = p.find_index($1)
      n = i >= 4 ? i+2 : i+1
      pass = p.rotate(-n).join()
    elsif line =~ /reverse positions (\d+) through (\d+)/
      i = $1.to_i
      j = $2.to_i
      pass[i..j] = pass[i..j].reverse
    elsif line =~ /move position (\d+) to position (\d+)/
      v = pass[$1.to_i]
      pass[v] = ''
      pass[$2.to_i] = pass[$2.to_i] ? v+pass[$2.to_i] : v
    end
  end
  pass
end

def unscramble(pass, inp)
  'fbgdceah'.split('').permutation(8).each do |p|
    return p.join() if scramble(p.join(), inp) == 'fbgdceah'
  end
end

inp = IO.readlines('inputs/q21.txt', chomp: true)
puts "Part1: #{scramble('abcdefgh', inp)}"
puts "Part2: #{unscramble('fbgdceah', inp)}"
