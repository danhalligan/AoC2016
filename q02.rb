
def move(i, j, moves)
  moves.split(//).each do |x|
    case x
    when 'U' then j = [j - 1, 0].max
    when 'D' then j = [j + 1, 2].min
    when 'L' then i = [i - 1, 0].max
    when 'R' then i = [i + 1, 2].min
    end
  end
  [i, j]
end

moves = IO.readlines("inputs/q02.txt", chomp: true)

i, j = 0, 0
code = moves.map do |x|
  i, j = move(i, j, x)
  (i + j*3) + 1
end
puts "Part1: #{code.join()}"




def move(i, j, moves)
  mask = {
    [0,0] => 1, [0,1] => 1, [1,0] => 1,
    [3,0] => 1, [4,0] => 1, [4,1] => 1,
    [0,3] => 1, [0,4] => 1, [1,4] => 1,
    [3,4] => 1, [4,3] => 1, [4,4] => 1
  }
  moves.split(//).each do |x|
    case x
    when 'U' then j = [j - 1, 0].max unless mask.key?([i, j - 1])
    when 'D' then j = [j + 1, 4].min unless mask.key?([i, j + 1])
    when 'L' then i = [i - 1, 0].max unless mask.key?([i - 1, j])
    when 'R' then i = [i + 1, 4].min unless mask.key?([i + 1, j])
    end
  end
  [i, j]
end

pad = {
  [2, 0] => '1',
  [1, 1] => '2', [2, 1] => '3', [3, 1] => '4',
  [0, 2] => '5', [1, 2] => '6', [2, 2] => '7', [3, 2] => '8',  [4, 2] => '9',
  [1, 3] => 'A', [2, 3] => 'B', [3, 3] => 'C',
  [2, 4] => 'D'
}

i, j = 0, 2
code = moves.map do |x|
  i, j = move(i, j, x)
  pad[[i, j]]
end
puts "Part2: #{code.join()}"

