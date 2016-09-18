module Scale
  module Endpoints
    module Tasks
      class CreatePhonecallTask < TaskEndpoint
        def process
          response = api.request :post, path('comparison'), params
          build_task response
        end

        def self.shortcut
          'create_phonecall_task'
        end
      end
    end
  end
end
