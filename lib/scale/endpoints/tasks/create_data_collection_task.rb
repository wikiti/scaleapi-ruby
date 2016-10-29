module Scale
  module Endpoints
    module Tasks
      class CreateDataCollectionTask < TaskEndpoint
        def process
          response = api.request :post, path('datacollection'), params
          build_task response
        end

        def self.shortcut
          'create_data_collection_task'
        end
      end
    end
  end
end
