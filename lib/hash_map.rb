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
    node = Node.new(key, value)
    bucket_index = hash(key) % @capacity
    @buckets[bucket_index] = node
  end

  def get(key)
    bucket_index = hash(key) % @capacity
    @buckets[bucket_index].value
  end

  def has?(key)
    bucket_index = hash(key) % @capacity
    return true if !@buckets[bucket_index].nil? && @buckets[bucket_index].key == (key)

    false
  end

  # Will not work if multiple k/v pairs...DELETES ENTIRE BUCKET
  def remove(key)
    return nil unless has?(key)

    deleted_value = get(key)
    bucket_index = hash(key) % @capacity
    @buckets[bucket_index] = nil
    deleted_value
  end
end

hash_map = HashMap.new
hash_map.set("test", 5)
hash_map.get("test")
hash_map.has?("test")
p hash_map.buckets
p hash_map.remove("test")
p hash_map.buckets
