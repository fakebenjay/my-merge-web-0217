class Hash 
  def my_merge(other_hash, &block)
    keys = (self.keys + other_hash.keys)
    keys.each_with_object(Hash.new) do |key, merge|
      next if merge.has_key? key
      if keys.count(key) > 1 && block_given?
        merge[key] = block.call(key, self[key], other_hash[key])
      else
        merge[key] = other_hash[key] || self[key]
      end
    end
  end
end