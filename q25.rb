load './interpreter.rb'

def solve
  1.step do |i|
    comp = Interpreter.new('inputs/q25.txt', {'a'=>i, 'b'=>0, 'c'=>0, 'd'=>0})
    print '.'
    comp.each.each_with_index do |x, j|
      break unless x == j % 2
      if j == 500
        puts
        return i
      end
    end
  end
end

puts "Part1: #{solve()}"
