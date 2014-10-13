require 'spec_helper'
require 'collection-json/attributes/data'

describe CollectionJSON::Data do
  it 'displays value "false"' do
    expect(CollectionJSON::Data.from_hash(value: false).to_json).to eq "{\"value\":false}"
  end
end
