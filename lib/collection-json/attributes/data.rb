require_relative '../attribute'

module CollectionJSON
  class Data < Attribute
    attribute :name
    attribute :value
    attribute :prompt
  end
end
