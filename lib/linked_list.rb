require_relative "node"

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  attr_accessor :head, :tail

  def append(key, value)
    node = Node.new(key, value)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(key, value)
    node = Node.new(key, value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def size
    current = @head
    count = 0
    until current.nil?
      count += 1
      current = current.next_node
    end
    count
  end

  def at(index)
    current = head
    index.times do
      current = current.next_node
    end
    current
  end

  def pop
    tail_index = size - 1
    @tail = at(tail_index - 1)
    @tail.next_node = nil
  end

  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    count = 0
    until current.nil?
      return count if current.value == value

      count += 1
      current = current.next_node
    end
    nil
  end

  def to_s
    current = @head
    string_display = ""
    size.times do
      string_display << "( #{current.value} ) -> "
      current = current.next_node
    end
    string_display << "nil"
    string_display
  end
end
