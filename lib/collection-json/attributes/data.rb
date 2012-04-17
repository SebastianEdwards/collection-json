module CollectionJSON
  class Data < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def name; self['name']; end
    def name=(value); self['name'] = value; end

    def value; self['value']; end
    def value=(value); self['value'] = value; end

    def prompt; self['prompt']; end
    def prompt=(value); self['prompt'] = value; end
  end
end
