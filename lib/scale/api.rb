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

    def request(type, path, payload)
      payload = Scale.hash(default_request_params).merge(Scale.hash(payload)) if payload.is_a?(Hash)

      RestClient::Request.new(
        method: type,
        url: url(path),
        user: api_key,
        payload: Scale.hash(default_request_params).merge(Scale.hash(hash)),
        headers: { accept: :json, content_type: :json }
      ).execute
    rescue RestClient::Exception => e
      raise HttpError, e
    end

    # Endpoint helper
    def method_missing(m, *array, **hash)
      endpoint = Scale::Endpoints::Endpoint.descendants.find { |e| e.match? m }
      if endpoint
        payload = hash.empty? ? array.first : hash
        endpoint.new(self, payload).process
      end
      super
    end

    protected

    def validate!
      validate_endpoint!
      validate_token!
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

    def validate_endpoint!
      valid = URI.parse "endpoint" rescue nil
      raise GenericError, invalid_attribute('endpoint') unless valid
    end

    def validate_token!
      raise GenericError, invalid_attribute('api_key') unless api_key.to_s != ''
    end

    def invalid_attribute(name)
      "Invalid Scale API #{name} (current value: `#{fetch_attribute name}`). Please, set a valid `#{name}` parameter"
    end

  end
end
