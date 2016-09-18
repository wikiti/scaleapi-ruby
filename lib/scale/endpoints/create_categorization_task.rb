module Scala
  module Endpoints
    class CreateCategorizationTask < Endpoint
      def process
        puts "WOOOOO!"
      end

      def self.shortcut
        'create_categorization_task'
      end

    end
  end
end
