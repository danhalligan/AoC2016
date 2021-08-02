class Node
  attr_accessor :next, :value, :num

  def initialize(value, num, nextnode = nil)
    @value = value
    @num = num
    @next = nextnode
  end
end

class Circle
  def initialize(x)
    x = x.dup
    n = x.length+1
    @head = Node.new(x.shift, 1)
    @head.next = @head
    while x.length > 0
      n -= 1
      add(x.pop, n)
    end
  end

  def add(v, n)
    node = @head
    save = node.next
    node.next = Node.new(v, n)
    node.next.next = save
  end

  def move
    @head = @head.next
  end

  def next(n = @head)
    n.next
  end

  def value
    @head.value
  end

  def value=(val)
    @head.value = val
  end

  def num
    @head.num
  end
end
