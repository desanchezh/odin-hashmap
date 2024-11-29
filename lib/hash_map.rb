require_relative "linked_list"

class HashMap
  attr_accessor :capacity, :buckets

  def initialize
    @load_factor = 1
    @capacity = 16
    @buckets = Array.new(16)
  end

  # key should be string
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  # HOW TO CHECK FOR COLLISIONS BEFORE OVERWRITING VALUE?
  # NEEDS GROWTH LOGIC ie. when load factor is reached
  def set(key, value)
    linked_list = LinkedList.new
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index] = linked_list.append(key, value)
  end

  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index].value
  end

  def has?(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    return true if !@buckets[index].nil? && @buckets[index].key == (key)

    false
  end

  # Will not work if multiple k/v pairs...DELETES ENTIRE BUCKET
  def remove(key)
    return nil unless has?(key)

    deleted_value = get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index] = nil
    deleted_value
  end

  def length
    @buckets.length - @buckets.count(nil)
  end
end

hash_map = HashMap.new
hash_map.set("test", 5)
hash_map.get("test")
hash_map.has?("test")
p hash_map.buckets
p hash_map.length
