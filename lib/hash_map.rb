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

  def remove(key)
    return nil unless has?(key)

    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    current = @buckets[index].head
    removed = []
    @buckets.size.times do
      next if current.nil?

      # leftover empty node remains doing it like this
      if current.key == key
        removed << current.value
        current.value = nil
        current.key = nil
      end
      current = current.next_node
    end
    removed
  end

  def clear
    @buckets = []
    create_buckets(@capacity)
  end

  def values
    values = []
    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket.head
      bucket.size.times do
        unless current.nil?
          values << current.value
          current = current.next_node
        end
      end
    end
    values
  end

  def size
    values.count
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket.head
      bucket.size.times do
        next if current.nil?

        pair = []
        pair << current.key
        pair << current.value
        current = current.next_node
        entries << pair
      end
    end
    entries
  end
end
