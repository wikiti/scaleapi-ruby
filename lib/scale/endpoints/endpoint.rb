module Scala
  module Endpoints
    class Endpoint
      attr_reader :api, :params

      def initialize(api, params = {})
        @api = api
        @params = params
      end

      def process
        raise NotImplementedError
      end

      def self.shortcut
        raise NotImplementedError
      end

      def self.match?(method)
        shortcut == method
      end

      def self.descendants
        ObjectSpace.each_object(::Class).select {|klass| klass < self }
      end
    end
  end
end
