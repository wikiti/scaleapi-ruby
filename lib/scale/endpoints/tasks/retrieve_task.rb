module Scale
  module Endpoints
    module Tasks
      class RetrieveTask < TaskEndpoint
        attr_reader :task_id

        def initialize(api, *args)
          super
          @task_id = args.first
        end

        def process
          response = api.request :get, path(task_id)
          build_task response
        end

        def self.shortcut
          'retrieve_task'
        end
      end
    end
  end
end
