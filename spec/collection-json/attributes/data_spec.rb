require 'spec_helper'
require 'collection-json/attributes/data'

describe CollectionJSON::Data do
  it 'displays value "false"' do
    CollectionJSON::Data.from_hash(value: false).to_json.should == "{\"value\":false}"
  end
end
