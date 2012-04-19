require_relative '../attribute'
require_relative 'data'
require_relative 'link'

module CollectionJSON
  class Item < Attribute
    attribute :href, transform: URI
    attribute :data,
              transform:  lambda { |data| data.each.map { |d| Data.from_hash(d) }},
              default:    []
    attribute :links,
              transform:  lambda { |links| links.each.map { |l| Link.from_hash(l) }},
              default:    []
  end
end
