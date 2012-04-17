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
      data = self.data.inject([]) do |array,data|
        result = data.select {|k,v| %w{name value}.include?(k)}
        result['value'] = params[data.name] if params[data.name]
        result['value'] != nil ? array << result : array
      end
      { 'template' => { 'data' => data } }
    end
  end
end
