require_relative 'data'

module CollectionJSON
  class Template < Attribute
    attribute :data,
              transform:      lambda { |data| data.each.map { |d| Data.from_hash(d) }},
              default:        [],
              find_method:    {method_name: :datum, key: 'name'}

    def build(params = {})
      {'template' => Hash.new}.tap do |hash|
        hash['template']['data'] = data.inject([]) do |array,data|
          result = {'name' => data.name, 'value' => data.value}
          result['value'] = params[data.name] unless params[data.name].nil?
          result['value'] = params[data.name.to_sym] unless params[data.name.to_sym].nil?
          result['value'].nil? ? array : array << result
        end
      end
    end
  end
end
