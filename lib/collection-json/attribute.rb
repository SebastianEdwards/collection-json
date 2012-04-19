require 'json'

Dir[File.dirname(__FILE__) + "/transformers/*.rb"].each do |file|
  require file
end

module CollectionJSON
  class Attribute
    def self.nested_attributes
      @nested_attributes ||= []
    end

    def self.attribute(name, opts={})
      nested_attributes << name
      define_method(name) do |arg=nil|
        if arg
          if opts[:transform]
            instance_variable_set(:"@#{name}", opts[:transform].call(arg))
          else
            instance_variable_set(:"@#{name}", arg)
          end
        else
          unless instance_variable_get(:"@#{name}").nil?
             instance_variable_get(:"@#{name}")
           else
            opts[:default]
          end
        end
      end
    end

    def self.root_node(value = nil)
      @root_node = value.to_s if value
      @root_node
    end

    def self.from_hash(hash)
      self.new.tap do |item|
        hash.each { |k,v| item.send(k, v) if item.respond_to?(k) }
      end
    end

    def to_hash
      hash = Hash.new.tap do |item|
        self.class.nested_attributes.each do |attribute|
          value = send(attribute)
          item[attribute] = value unless skip_value?(value)
        end
      end
      self.class.root_node ? {self.class.root_node => hash} : hash
    end

    def to_json(*args)
      to_hash.to_json(args)
    end

    private
    def skip_value?(value)
      value.nil? || value.respond_to?(:length) && value.length == 0
    end
  end
end
