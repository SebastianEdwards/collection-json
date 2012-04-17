require_relative 'link'
require_relative 'data'

module CollectionJSON
  class Item < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def href; self['href']; end
    def href=(value); self['href'] = value; end

    def links
      self['links'].map {|link| Link.from_hash(link)}
    end

    def links=(array)
      self['links'] = array
    end

    def data
      self['data'].map {|data| Data.from_hash(data)}
    end

    def data=(array)
      self['data'] = array
    end
  end
end
