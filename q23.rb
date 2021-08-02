load './interpreter.rb'
comp = Interpreter.new('inputs/q23.txt', {'a'=>7, 'b'=>0, 'c'=>0, 'd'=>0})
puts "Part1: #{comp.run}"

comp = Interpreter.new('inputs/q23.txt', {'a'=>12, 'b'=>0, 'c'=>0, 'd'=>0})
puts "Part2: #{comp.run}"
