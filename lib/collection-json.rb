require 'json'
require "collection-json/version"
require "collection-json/collection"
require "collection-json/builder"

COLLECTION_JSON_VERSION = "1.0"
ROOT_NODE = 'collection'

VALID_LINK_ATTRIBUTES = %w{href rel name render prompt}.map(&:to_sym)

module CollectionJSON
  def self.generate_for(href, &block)
    response = Collection.new(href)
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
    collection = Collection.from_hash(hash)
  end
end
