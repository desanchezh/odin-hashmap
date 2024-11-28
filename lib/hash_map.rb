class HashMap
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
end
