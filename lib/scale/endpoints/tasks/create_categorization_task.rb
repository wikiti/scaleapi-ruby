module Scale
  module Endpoints
    module Tasks
      class CreateCategorizationTask < TaskEndpoint
        def process
          response = api.request :post, path('categorize'), params
          build_task response
        end

        def self.shortcut
          'create_categorization_task'
        end
      end
    end
  end
end
