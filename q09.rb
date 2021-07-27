def decompress(x)
  replacements = []
  offset = 0
  while m = x.match(/\((\d+)x(\d+)\)/, offset)
    len, rep = m.captures.map(&:to_i)
    s, e = m.offset(0)
    e2 = e+len-1
    replacements += [[s, e2, x[e..e2] * rep]]
    offset = e+len-1
  end

  while replacements.length > 0 do
    rep = replacements.pop
    x[rep[0]..rep[1]] = rep[2]
  end
  x
end

def recursive_decompression_len(x)
  weight = [1]*x.length
  prune = []
  while x.match(/\((\d+)x(\d+)\)/)
    offset = 0
    while m = x.match(/\((\d+)x(\d+)\)/, offset)
      len, rep = m.captures.map(&:to_i)
      s, e = m.offset(0)
      e2 = e+len-1
      (e..e2).map {|i| weight[i] = weight[i]*rep}
      offset = e+len-1
      prune += [[s, e-1]]
    end

    while prune.length > 0 do
      rep = prune.pop
      x[rep[0]..rep[1]] = ''
      weight.slice!(rep[0]..rep[1])
    end
  end
  weight.sum
end

dat = IO.readlines('inputs/q09.txt', chomp: true)[0]
puts "Part1: #{decompress(dat).length}"
puts "Part2: #{recursive_decompression_len(dat.clone)}"
