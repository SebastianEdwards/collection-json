require 'collection-json/attributes/template'

module CollectionJSON
  module Goliath
    COLLECTION_JSON_ENCODED = %r{^application/vnd\.collection\+json}

    class Params
      module Parser
        def retrieve_params(env)
          env['params'].tap do |params|
            if env['rack.input']
              body = env['rack.input'].read
              env['rack.input'].rewind
              unless body.empty?
                if env['CONTENT_TYPE'].match COLLECTION_JSON_ENCODED
                  begin
                    hash = JSON.parse(body)
                    template = Template.from_hash(hash['template'])
                    template.data.each do |datum|
                      params.merge! datum.name => datum.value
                    end
                  rescue StandardError => e
                    raise ::Goliath::Validation::BadRequestError, "Invalid parameters: #{e.class.to_s}"
                  end
                end
              end
            end
          end
        end
      end

      include ::Goliath::Rack::Validator
      include Parser

      def initialize(app)
        @app = app
      end

      def call(env)
        ::Goliath::Rack::Validator.safely(env) do
          env['params'] = retrieve_params(env)
          @app.call(env)
        end
      end
    end
  end
end
