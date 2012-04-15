require "collection-json/version"
require "collection-json/response"
require "collection-json/builder"

COLLECTION_JSON_VERSION = "1.0"
COLLECTION_JSON_HOST = ENV['COLLECTION_JSON_HOST']

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
    if COLLECTION_JSON_HOST && !href[/^http/]
      COLLECTION_JSON_HOST + href
    else
      href
    end
  end
end
