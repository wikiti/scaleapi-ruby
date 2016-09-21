module Scale
  module Callbacks
    class Base
      attr_reader :response, :json

      def initialize(data)
        @json = Scale.hash(data)
        @response = json[:response]
      end

      def status_code
        response[:status_code]
      end


      def self.shortcut
        raise NotImplementedError
      end

      def self.match?(method)
        shortcut.to_s == method.to_s
      end
    end
  end
end
