module CollectionJSON
  class Builder
    attr_reader :collection

    def initialize(collection)
      @collection = collection
    end

    def set_error(opts = {})
      collection.error = opts
    end

    def set_code(code)
      collection.code = code
    end

    def add_link(href, rel, opts = {})
      href = CollectionJSON.add_host(href)

      opts.select! {|k,v| VALID_LINK_ATTRIBUTES.include? k}
      opts.merge!({'rel' => rel, 'href' => href})
      collection.links << Link.from_hash(opts)
    end

    def add_item(href, data = [], links = [], &block)
      href = CollectionJSON.add_host(href)
      collection.items << Item.from_hash({'href' => href}).tap do |item|
        item_builder = ItemBuilder.new(data, links)
        yield(item_builder) if block_given?
        item.merge!({'data' => item_builder.data}) if item_builder.data.length > 0
        item.merge!({'links' => item_builder.links}) if item_builder.links.length > 0
      end
    end

    def add_query(href, rel, prompt = '', data = [], &block)
      href = CollectionJSON.add_host(href)
      collection.queries << Query.from_hash({'href' => href, 'rel' => rel}).tap do |query|
        query_builder = QueryBuilder.new(data)
        yield(query_builder) if block_given?
        query.merge!({'prompt' => prompt}) if prompt != ''
        query.merge!({'data' => query_builder.data}) if query_builder.data.length > 0
      end
    end

    def set_template(data = [], &block)
      collection.template = Template.new.tap do |template|
        template_builder = TemplateBuilder.new(data)
        yield(template_builder) if block_given?
        template.merge!({'data' => template_builder.data}) if template_builder.data.length > 0
      end
    end
  end

  class ItemBuilder
    attr_reader :data, :links

    def initialize(data, links)
      @data = data
      @links = links
    end

    def add_data(name, value = '', prompt = '')
      data << {name: name}.tap do |data|
        data.merge!({'value' => value}) if value != ''
        data.merge!({'prompt' => prompt}) if prompt != ''
      end
    end

    def add_link(href, rel, name = '', prompt = '', render = '')
      href = CollectionJSON.add_host(href)
      links << Link.from_hash({'href' => href, 'rel' => rel}).tap do |link|
        link.merge!({'name' => name}) if name != ''
        link.merge!({'prompt' => prompt}) if prompt != ''
        link.merge!({'render' => render}) if render != ''
      end
    end
  end

  class QueryBuilder
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def add_data(name, value = '', prompt = '')
      data << Data.from_hash({'name' => name}).tap do |data|
        data.merge!({'value' => value}) if value != ''
        data.merge!({'prompt' => prompt}) if prompt != ''
      end
    end
  end

  class TemplateBuilder
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def add_data(name, value = '', prompt = '')
      data << Data.from_hash({'name' => name}).tap do |data|
        data.merge!({'value' => value}) if value != ''
        data.merge!({'prompt' => prompt}) if prompt != ''
      end
    end
  end
end
