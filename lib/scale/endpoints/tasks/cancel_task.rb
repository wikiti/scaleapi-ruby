module Scale
  module Endpoints
    module Tasks
      class CancelTask < TaskEndpoint
        def process
          response = api.request :post, path("#{fetch_param :task_id}/cancel")
          build_task response
        end

        def self.shortcut
          'cancel_task'
        end
      end
    end
  end
end
