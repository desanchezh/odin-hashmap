class Node
  def initialize(value = nil, key = nil)
    @key = key
    @value = value
  end

  attr_accessor :value, :key
end
