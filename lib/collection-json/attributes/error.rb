require_relative '../attribute'

module CollectionJSON
  class Error < Attribute
    attribute :title
    attribute :code
    attribute :message
  end
end
