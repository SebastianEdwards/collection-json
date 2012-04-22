require 'spec_helper'
require 'collection-json'

describe CollectionJSON do
  describe :generate_for do
    before :each do
      @friends = [
        {
          "id"        =>  "jdoe",
          "full-name" =>  "J. Doe",
          "email"     =>  "jdoe@example.org"
        },
        {
          "id"        =>  "msmith",
          "full-name" =>  "M. Smith",
          "email"     =>  "msmith@example.org"
        },
        {
          "id"        =>  "rwilliams",
          "full-name" =>  "R. Williams",
          "email"     =>  "rwilliams@example.org"
        }
      ]
    end

    it 'should generate an object with the attributes we expect' do
      response = CollectionJSON.generate_for('/friends/') do |builder|
        builder.add_link '/friends/rss', 'feed'
        @friends.each do |friend|
          builder.add_item("/friends/#{friend['id']}") do |item|
            item.add_data "full-name", value: friend["full-name"]
            item.add_data "email", value: friend["email"]
            item.add_link "/blogs/#{friend['id']}", "blog", prompt: "Blog"
            item.add_link "/blogs/#{friend['id']}", "avatar", prompt: "Avatar", render: 'image'
          end
        end
        builder.add_query("/friends/search", "search", prompt: "Search") do |query|
          query.add_data "search"
        end
        builder.set_template do |template|
          template.add_data "full-name", prompt: "Full Name"
          template.add_data "email", prompt: "Email"
          template.add_data "blog", prompt: "Blog"
          template.add_data "avatar", prompt: "Avatar"
        end
      end

      response.href.should eq('/friends/')
      response.links.first.href.should eq("/friends/rss")
      response.link('feed').href.should eq("/friends/rss")
      response.items.length.should eq(3)
      response.items.first.data.length.should eq(2)
      response.items.first.datum('full-name').value.should eq("J. Doe")
      response.items.first.links.length.should eq(2)
      response.items.first.href.class.should eq(String)
      response.template.data.length.should eq(4)
      response.queries.length.should eq(1)
      response.queries.first.href.should eq("/friends/search")
      response.queries.first.data.length.should eq(1)
      response.queries.first.data.first.name.should eq('search')
      response.query('search').prompt.should eq('Search')
    end
  end

  describe :parse do
    before(:all) do
      json = '{"collection": {
        "href": "http://www.example.org/friends",
        "links": [
          {"rel": "feed", "href": "http://www.example.org/friends.rss"}
        ],
        "items": [
          {
            "href": "http://www.example.org/m.rowe",
            "data": [
              {"name": "full-name", "value": "Matt Rowe"}
            ]
          }
        ]
      }}'
      @collection = CollectionJSON.parse(json)
    end

    it 'should parse JSON into a Collection' do
      @collection.class.should eq(CollectionJSON::Collection)
    end

    it 'should have correct href' do
      @collection.href.should eq("http://www.example.org/friends")
    end

    it 'should handle the nested attributes' do
      @collection.items.first.href.should eq("http://www.example.org/m.rowe")
      @collection.items.first.data.count.should eq(1)
    end

    it 'should be able to be reserialized' do
      @collection.to_json.class.should eq(String)
    end

    it 'should have the correct link' do
      @collection.links.first.href.should eq("http://www.example.org/friends.rss")
    end
  end
end
