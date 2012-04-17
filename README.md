# CollectionJSON

A lightweight gem to easily build and parse response objects with a MIME type of
'application/vnd.collection+json'.

Read http://amundsen.com/media-types/collection/ for more information about this
media type.

## Usage

### Building

Use ```CollectionJSON.generate_for``` to build a response object which you can
call ```to_json``` on.

```ruby
collection = CollectionJSON.generate_for('/friends/') do |builder|
  builder.add_link '/friends/rss', 'feed'
  user.friends.each do |friend|
    builder.add_item("/friends/#{friend.id}") do |item|
      item.add_data "full-name", friend.full_name
      item.add_data "email", friend.email
      item.add_link "/blogs/#{friend.id}", "blog", "", "Blog"
      item.add_link "/blogs/#{friend.id}", "avatar", "", "Avatar", "image"
    end
  end
  builder.add_query("/friends/search", "search", "Search") do |query|
    query.add_data "search"
  end
  builder.set_template do |template|
    template.add_data "full-name", "", "Full Name"
    template.add_data "email", "", "Email"
    template.add_data "blog", "", "Blog"
    template.add_data "avatar", "", "Avatar"
  end
end

collection.to_json
```

Output:

```javascript
{ "collection" :
  {
    "version" : "1.0",
    "href" : "http://example.org/friends/",
    
    "links" : [
      {"rel" : "feed", "href" : "http://example.org/friends/rss"}
    ],
    
    "items" : [
      {
        "href" : "http://example.org/friends/jdoe",
        "data" : [
          {"name" : "full-name", "value" : "J. Doe", "prompt" : "Full Name"},
          {"name" : "email", "value" : "jdoe@example.org", "prompt" : "Email"}
        ],
        "links" : [
          {"rel" : "blog", "href" : "http://example.org/blogs/jdoe", "prompt" : "Blog"},
          {
            "rel" : "avatar", "href" : "http://example.org/images/jdoe",
            "prompt" : "Avatar", "render" : "image"
          }
        ]
      },
      
      {
        "href" : "http://example.org/friends/msmith",
        "data" : [
          {"name" : "full-name", "value" : "M. Smith", "prompt" : "Full Name"},
          {"name" : "email", "value" : "msmith@example.org", "prompt" : "Email"}
        ],
        "links" : [
          {"rel" : "blog", "href" : "http://example.org/blogs/msmith", "prompt" : "Blog"},
          {
            "rel" : "avatar", "href" : "http://example.org/images/msmith",
            "prompt" : "Avatar", "render" : "image"
          }
        ]
      },
      
      {
        "href" : "http://example.org/friends/rwilliams",
        "data" : [
          {"name" : "full-name", "value" : "R. Williams", "prompt" : "Full Name"},
          {"name" : "email", "value" : "rwilliams@example.org", "prompt" : "Email"}
        ],
        "links" : [
          {"rel" : "blog", "href" : "http://example.org/blogs/rwilliams", "prompt" : "Blog"},
          {
            "rel" : "avatar", "href" : "http://example.org/images/rwilliams",
            "prompt" : "Avatar", "render" : "image"
          }
        ]
      }      
    ],
    
    "queries" : [
      {"rel" : "search", "href" : "http://example.org/friends/search", "prompt" : "Search",
        "data" : [
          {"name" : "q", "prompt" : "Search Query"}
        ]
      }
    ],
    
    "template" : {
      "data" : [
        {"name" : "full-name", "prompt" : "Full Name"},
        {"name" : "email", "prompt" : "Email"},
        {"name" : "blog", "prompt" : "Blog"},
        {"name" : "avatar", "prompt" : "Avatar"}
        
      ]
    }
  } 
}
```

### Parsing

CollectionJSON also helps you to consume APIs by parsing JSON strings:

```ruby
collection = CollectionJSON.parse(json)
collection.href # => "http://example.org/friends/"
collection.items.count # => 3
```

You can then build queries:

```ruby
collection.queries.first.build({'search' => 'puppies'}) # => "http://example.org/friends/search?q=puppies"
```

It also builds templates:

```ruby
built_template = collection.template.build({"full-name" => "Lol Cat", "email" => "lol@cats.com"})
built_template.to_json
```

Output:

```javascript
{
  "template" : {
    "data" : [
      {
        "name" : "full-name",
        "value" : "Lol Cat"
      },
      {
        "name" : "email",
        "value" : "lol@cats.com"
      }
    ]
  }
}
```

## Notes

Set the ```COLLECTION_JSON_HOST``` environment variable to automatically add
this to the href's. Eg. ```COLLECTION_JSON_HOST=http://example.org```

## Installation

Add this line to your application's Gemfile:

    gem 'collection-json'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collection-json
