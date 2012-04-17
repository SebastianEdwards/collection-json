require_relative 'data'

module CollectionJSON
  class Query < Hash
    def self.from_hash(hash)
      self.new.merge! hash
    end

    def href; self['href']; end
    def href=(value); self['href'] = value; end

    def rel; self['rel']; end
    def rel=(value); self['rel'] = value; end

    def name; self['name']; end
    def name=(value); self['name'] = value; end

    def prompt; self['prompt']; end
    def prompt=(value); self['prompt'] = value; end

    def data; self['data']; end
    def data=(array)
      self['data'] = array.map {|data| Data.from_hash(data)}
    end

    def build(params = {})
      URI(href).tap do |uri|
        uri.query = add_query_params(uri.query || '', params)
      end.to_s.gsub(/\?$/, '')
    end

    private
    def add_query_params(query, params)
      query << params.keys.inject('') do |query, key|
        query.tap do |query_string|
          unless data.map(&name).include?(key)
            query << '&' unless key == params.keys.first
            query << CGI.escape(key.to_s)
            query << "=#{CGI.escape(params[key].to_s)}"
          end
        end
      end
    end
  end
end
