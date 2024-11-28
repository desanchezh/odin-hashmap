class Node
  def initialize(key = nil, value = nil)
    @key = key
    @value = value
    @next_node = nil
  end

  attr_accessor :value, :next_node, :key
end
