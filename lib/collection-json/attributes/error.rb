module CollectionJSON
  class Error < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def title; self['title']; end
    def title=(value); self['title'] = value; end

    def code; self['code']; end
    def code=(value); self['code'] = value; end

    def message; self['message']; end
    def message=(value); self['message'] = value; end
  end
end
