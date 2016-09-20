module Scale
  module Endpoints
    module Tasks
      class CancelTask < TaskEndpoint
        attr_reader :task_id

        def initialize(api, *args)
          super
          @task_id = args.first
        end

        def process
          response = api.request :post, path("#{task_id}/cancel")
          build_task response
        end

        def self.shortcut
          'cancel_task'
        end
      end
    end
  end
end
