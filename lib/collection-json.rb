require 'json'
require "collection-json/version"
require "collection-json/attributes/collection"
require "collection-json/builder"

COLLECTION_JSON_VERSION = "1.0"
ROOT_NODE = 'collection'

module CollectionJSON
  def self.generate_for(href, &block)
    response = Collection.new
    response.href href
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

  def self.parse(json)
    hash = JSON.parse(json)
    collection = Collection.from_hash(hash[ROOT_NODE])
  end
end
