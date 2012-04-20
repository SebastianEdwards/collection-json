require_relative '../attribute'
require_relative 'data'

module CollectionJSON
  class Query < Attribute
    attribute :href, transform: URI
    attribute :rel
    attribute :name
    attribute :prompt
    attribute :data,
              transform:  lambda { |data| data.each.map { |d| Data.from_hash(d) }},
              default:    []

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
