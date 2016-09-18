module Scale
  module Endpoints
    module Tasks
      class CreateAnnotationTask < TaskEndpoint
        def process
          response = api.request :post, path('annotation'), params
          build_task response
        end

        def self.shortcut
          'create_annotation_task'
        end
      end
    end
  end
end
