module Scale
  module Endpoints
    module Tasks
      class RetrieveTask < TaskEndpoint
        def process
          response = api.request :get, path(fetch_param :task_id)
          build_task response
        end

        def self.shortcut
          'retrieve_task'
        end
      end
    end
  end
end
