module Scale
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
        ''
      end

      def self.match?(method)
        shortcut.to_s == method.to_s
      end

      def self.descendants
        ObjectSpace.each_object(::Class).select {|klass| klass < self }
      end

      protected

      def fetch_param(name)
        params[name.to_s] || params[name.to_sym]
      end
    end
  end
end
