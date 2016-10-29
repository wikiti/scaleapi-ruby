module Scale
  class API
    DEFAULT_PARAMS = {
      endpoint: 'https://api.scaleapi.com/v1/',
      default_request_params: {}
    }.freeze

    attr_reader :endpoint, :api_key, :callback_key, :default_request_params, :params

    def initialize(params = {})
      params = DEFAULT_PARAMS.merge params

      @params = Scale.hash(params)
      @endpoint = fetch_attribute :endpoint
      @api_key = fetch_attribute :api_key
      @callback_key = fetch_attribute :callback_key
      @default_request_params = fetch_attribute :default_request_params

      validate!
    end

    def request(type, path, payload = {})
      RestClient::Request.new(
        method: type,
        url: url(path),
        user: api_key,
        payload: Scale.hash(default_request_params).merge(Scale.hash(payload)).to_json,
        headers: { accept: :json, content_type: :json }
      ).execute
    rescue RestClient::Exception => e
      raise HttpError, e
    end

    def build_callback(data, type = 'task', options = {})
      options = Scale.hash options
      matchers = Scale.descendants(Scale::Callbacks::Base)
      klass = matchers.find { |c| c.match? type }

      validate_callback_handler! klass
      validate_callback_token! options[:callback_key]

      klass.new data
    end

    def valid_callback_key?(key)
      key.to_s == callback_key.to_s
    end

    # Endpoint helper. If the method is not defined, then try looking into the available endpoints.
    def method_missing(m, *array)
      endpoint = Scale.descendants(Scale::Endpoints::Endpoint).find { |e| e.match? m }
      return endpoint.new(self, *array).process if endpoint
      super
    end

    protected

    def validate!
      validate_endpoint!
      validate_api_key!
      validate_callback_key!
    end

    def fetch_attribute(name)
      params[name] || send(name)
    end

    def url(path)
      "#{endpoint.end_with?('/') ? endpoint : endpoint + '/'}#{path}"
    end

    # -------------------
    #      Validators
    # -------------------

    def validate_callback_handler!(klass)
      raise GenericError, "Callback handler '#{name}' not found. Try #{matchers.map(&:shortcut).join ','}" unless klass
    end

    def validate_callback_token!(key)
      return if callback_key.nil?
      raise GenericError, "Invalid HTTP callback with key #{key}" unless valid_callback_key? key
    end

    def validate_callback_key!
      return if callback_key.nil?
      raise GenericError, invalid_attribute('callback_key') unless api_key.to_s != ''
    end

    def validate_endpoint!
      valid = URI.parse "endpoint" rescue nil
      raise GenericError, invalid_attribute('endpoint') unless valid
    end

    def validate_api_key!
      raise GenericError, invalid_attribute('api_key') unless api_key.to_s != ''
    end

    def invalid_attribute(name)
      "Invalid Scale API `#{name}`. Please, set a valid `#{name}` parameter"
    end

  end
end
