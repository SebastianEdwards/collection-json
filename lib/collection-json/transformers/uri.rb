module CollectionJSON
  class URI
    def self.call(href)
      if ENV['COLLECTION_JSON_HOST'] && !href[/^http/]
        ENV['COLLECTION_JSON_HOST'] + href
      else
        href
      end
    end
  end
end
