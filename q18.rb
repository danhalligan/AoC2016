class Traps
  include Enumerable

  def initialize(x)
    @x = x.split('').map {|x| x.match? /\^/}
  end

  def pad
    [false] + @x + [false]
  end

  def each(&block)
    while true
      yield @x.count(false)
      @x = (1..(@x.length)).map {|i| pad[i-1] != pad[i+1]}
    end
  end
end

inp = IO.read('inputs/q18.txt').chomp
puts "Part1: #{Traps.new(inp).first(40).sum}"
puts "Part2: #{Traps.new(inp).first(400000).sum}"
