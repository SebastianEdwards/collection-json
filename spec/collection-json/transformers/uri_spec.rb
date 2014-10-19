require 'spec_helper'
require 'collection-json/transformers/uri'

describe CollectionJSON::URI do
  before :each do
    @href = '/friends'
  end

  context 'with COLLECTION_JSON_HOST set' do
    it 'returns full uri' do
      ENV['COLLECTION_JSON_HOST'] = EXAMPLE_HOST
      uri = CollectionJSON::URI.call(@href)
      expect(uri).to eq("http://localhost/friends")
    end
  end

  context 'without COLLECTION_JSON_HOST set' do
    it 'returns partial uri' do
      ENV['COLLECTION_JSON_HOST'] = nil
      uri = CollectionJSON::URI.call(@href)
      expect(uri).to eq("/friends")
    end
  end
end
