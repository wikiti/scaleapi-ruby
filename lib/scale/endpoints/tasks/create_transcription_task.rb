module Scale
  module Endpoints
    module Tasks
      class CreateTranscriptionTask < TaskEndpoint
        def process
          response = api.request :post, path('transcription'), params
          build_task response
        end

        def self.shortcut
          'create_transcription_task'
        end
      end
    end
  end
end
