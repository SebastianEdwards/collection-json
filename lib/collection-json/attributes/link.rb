module CollectionJSON
  class Link < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def href; self['href']; end
    def href=(value); self['href'] = value; end

    def rel; self['rel']; end
    def rel=(value); self['rel'] = value; end

    def name; self['name']; end
    def name=(value); self['name'] = value; end

    def render; self['render']; end
    def render=(value); self['render'] = value; end

    def prompt; self['prompt']; end
    def prompt=(value); self['prompt'] = value; end
  end
end
