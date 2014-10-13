require 'spec_helper'
require 'collection-json/attributes/template'

describe CollectionJSON::Template do
  before(:all) do
    @hash = {
      'data' => [
        {
          'name' => 'full-name',
          'prompt' => 'Full name'
        },
        {
          'name' => 'email',
          'prompt' => 'Email'
        }
      ]
    }
  end

  describe :build do
    it 'should build correctly' do
      template = CollectionJSON::Template.from_hash(@hash)
      result = template.build({
        'email' => 'test@example.com',
        'full-name' => 'Test Example'
      })
      json = result.to_json
      hash = JSON.parse(json)
      expect(hash['template']['data'].length).to eq(2)
      expect(hash['template']['data'].first.keys.length).to eq(2)
    end
  end
end
