require "collection-json/version"
require "collection-json/response"
require "collection-json/builder"

COLLECTION_JSON_VERSION = "1.0"

module CollectionJSON
  def self.generate_for(href, &block)
    response = Response.new(href)
    if block_given?
      builder = Builder.new(response)
      yield(builder)
    end

    response
  end

  def self.add_host(href)
    if ENV['COLLECTION_JSON_HOST'] && !href[/^http/]
      ENV['COLLECTION_JSON_HOST'] + href
    else
      href
    end
  end
end
