require_relative 'data'

module CollectionJSON
  class Template < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def data; self['data']; end
    def data=(array)
      self['data'] = array.map {|data| Data.from_hash(data)}
    end
  end
end
