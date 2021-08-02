class Interpreter
  attr_reader :program

  def initialize(file, reg = {'a'=>0, 'b'=>0, 'c'=>0, 'd'=>0})
    @program = IO.readlines(file, chomp: true).map{|x| x.split}
    @reg = reg
  end

  def as_val(x)
    x =~ /\d+/ ? x.to_i : @reg[x]
  end

  include Enumerable

  def run
    @pos = 0
    while true
      # puts @reg
      # puts program[@pos].join(" ")

      # this instruction set will set inc a by b d times
      # we'll execute this and then skip
      # if @program[@pos..@pos+5] == [["cpy", "b", "c"], ["inc", "a"], ["dec", "c"], ["jnz", "c", "-2"], ["dec", "d"], ["jnz", "d", "-5"]]
      #   @reg['a'] = @reg['d'] * @reg['b']
      #   @reg['c'] = 0
      #   @reg['d'] = 0
      #   @pos += 6
      #   next
      # end

      sc = @program[@pos..@pos+5].map{|x| x.join(' ')}.join(",")
      if sc =~ /cpy (\w) (\w),inc (\w),dec \2,jnz \2 -2,dec (\w),jnz \4 -5/
        @reg[$3] = @reg[$4] * as_val($1)
        @reg[$2] = 0
        @reg[$4] = 0
        @pos += 6
        next
      end

      sc = @program[@pos..(@pos+3)].map{|x| x.join(' ')}.join(",")
      if sc =~ /cpy (\w+) (\w),inc (\w),dec \2,jnz \2 -2/
        # puts "shortcut"
        @reg[$3] += as_val($1)
        @reg[$2] = 0
        @pos += 4
        next
      end

      # gets
      break if @pos >= @program.length
      x = @program[@pos]
      if x[0] == 'cpy'
        @reg[x[2]] = as_val(x[1]) unless x[2] =~ /\d/
        @pos += 1
      elsif x[0] == 'inc'
        @reg[x[1]] += 1
        @pos += 1
      elsif x[0] == 'dec'
        @reg[x[1]] -= 1
        @pos += 1
      elsif x[0] == 'jnz'
        @pos += as_val(x[1]) != 0 ? as_val(x[2]) : 1
      elsif x[0] == 'tgl'
        val = @pos + as_val(x[1])
        if @program[val]
          code = @program[val]
          if code.length == 2
            code[0] = code[0] == 'inc' ? 'dec' : 'inc'
          end
          if code.length == 3
            code[0] = code[0] == 'jnz' ? 'cpy' : 'jnz'
          end
        end
        @pos += 1
      elsif x[0] == 'out'
        block_given? ? (yield as_val(x[1])) : (return as_val(x[1]))
        @pos += 1
      end
    end
    @reg
  end

  def each(&block)
    to_enum(:run)
  end

end
