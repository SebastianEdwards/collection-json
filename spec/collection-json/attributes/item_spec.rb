require 'spec_helper'
require 'collection-json/attributes/item'

describe CollectionJSON::Item do
  it 'be serializable' do
    item = CollectionJSON::Item.from_hash({
      href: 'http://www.example.com',
      links: [{href: 'http://www.example.com/place'}],
      data: [{name: 'full-name', value: 'phil'}]
      })
    expect(item.to_json.class).to eq(String)
  end
end
