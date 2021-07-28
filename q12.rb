def as_val(x, reg)
  x =~ /\d+/ ? x.to_i : reg[x]
end

def run(program, reg = {'a'=>0, 'b'=>0, 'c'=>0, 'd'=>0})
  pos = 0
  while true
    break if pos >= program.length
    x = program[pos]
    if x[0] == 'cpy'
      reg[x[2]] = as_val(x[1], reg)
      pos += 1
    elsif x[0] == 'inc'
      reg[x[1]] += 1
      pos += 1
    elsif x[0] == 'dec'
      reg[x[1]] -= 1
      pos += 1
    elsif x[0] == 'jnz'
      pos += as_val(x[1], reg) != 0 ? x[2].to_i : 1
    end
  end
  reg
end

program = IO.readlines('inputs/q12.txt', chomp: true).map{|x| x.split}
puts "Part1: #{run(program)["a"]}"
puts "Part2: #{run(program, {'a'=>0, 'b'=>0, 'c'=>1, 'd'=>0})["a"]}"
