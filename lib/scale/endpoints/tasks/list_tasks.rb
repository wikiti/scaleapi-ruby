module Scale
  module Endpoints
    module Tasks
      class ListTasks < TaskEndpoint
        def process
          response = api.request :get, path
          build_tasks response
        end

        def self.shortcut
          'tasks'
        end

        protected

        def path
          'tasks'
        end

        def build_tasks(response)
          response = parse response
          Resources::Tasks.new response['docs'].map { |obj| build_task obj }, response
        end
      end
    end
  end
end
