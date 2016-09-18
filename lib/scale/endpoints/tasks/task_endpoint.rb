module Scale
  module Endpoints
    module Tasks
      class TaskEndpoint < Endpoint

        protected

        def path(p = '')
          "task/#{p}"
        end

        def build_task(response)
          Resources::Task.new parse(response)
        end

        def parse(response)
          JSON.parse(response.body) rescue response
        end
      end
    end
  end
end
