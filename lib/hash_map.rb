require_relative "linked_list"

class HashMap
  attr_accessor :capacity, :buckets

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = []
    create_buckets(@capacity)
  end

  def create_buckets(capacity)
    capacity.times do
      @buckets.push(LinkedList.new)
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  # key should be string

  # node should be linked list to deal with collisions
  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index].append(key, value)
  end

  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    current = @buckets[index].head
    value = []
    @buckets.size.times do
      unless current.nil?
        value << current.value if current.key == key
        current = current.next_node
      end
    end
    value
  end

  def has?(key)
    return true if get(key).any?

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

  def clear
    @buckets = Array.new(16)
  end

  def values
    values = []
    @buckets.each do |bucket|
      values << bucket.value unless bucket.nil?
    end
    values
  end

  def size
    @buckets.length - @buckets.count(nil)
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      pair = []
      pair << bucket.key unless bucket.nil?
      pair << bucket.value unless bucket.nil?
      entries << pair unless pair.empty?
    end
    entries
  end
end
