require_relative 'data'

module CollectionJSON
  class Template < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def data
      self['data'].map {|data| Data.from_hash(data)}
    end

    def data=(array)
      self['data'] = array
    end
    end
  end
end
