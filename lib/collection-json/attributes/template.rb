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

    def build(params = {})
      self.dup.tap do |result|
        result.data = result.data.map do |data|
          data.select! {|k,v| %w{name value}.include?(k)}
          data.value = params[data.name] if params[data.name]
          data
        end
      end
    end

    def to_json(*args)
      {template: Hash.new.merge!(self)}.to_json(args)
    end
  end
end
