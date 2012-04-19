require_relative 'data'

module CollectionJSON
  class Template < Attribute
    attribute :data,
              transform:  lambda { |data| data.each.map { |d| Data.from_hash(d) }},
              default:    []

    def build(params = {})
      {'template' => Hash.new}.tap do |hash|
        hash['template']['data'] = data.inject([]) do |array,data|
          result = {'name' => data.name, 'value' => data.value}
          result['value'] = params[data.name] if params[data.name]
          result['value'].nil? ? array : array << result
        end
      end
    end
  end
end
