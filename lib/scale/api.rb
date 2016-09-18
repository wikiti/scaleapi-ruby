module Scale
  class API
    DEFAULT_PARAMS = {
      endpoint: 'https://api.scaleapi.com/v1/'
    }.freeze

    attr_reader :endpoint, :api_key, :callback_key, :params

    def initialize(params = {})
      params = DEFAULT_PARAMS.merge params

      @params = params
      @endpoint = fetch_attribute :endpoint
      @api_key = fetch_attribute :api_key
      @callback_key = fetch_attribute :callback_key

      validate!
    end

    def request(type, path, **params)
      RestClient::Request.new(
        method: type,
        url: url(path),
        user: api_key,
        payload: params,
        headers: { accept: :json, content_type: :json }
      ).execute
    rescue RestClient::Exception => e
      raise HttpError, e
    end

    # Endpoint helper
    def method_missing(m, *array, **hash)
      endpoint = Scale::Endpoints::Endpoint.descendants.find { |e| e.match? m }
      return endpoint.new(self, hash).process if endpoint
      super
    end

    protected

    def validate!
      validate_endpoint!
      validate_token!
    end

    def fetch_attribute(name)
      params[name.to_sym] || params[name.to_s] || send(name)
    end

    def url(path)
      "#{endpoint.end_with?('/') ? endpoint : endpoint + '/'}#{path}"
    end

    # -------------------
    #      Validators
    # -------------------

    def validate_endpoint!
      raise GenericError, invalid_attribute('endpoint') unless endpoint =~ URI::regexp
    end

    def validate_token!
      raise GenericError, invalid_attribute('api_key') unless api_key.to_s != ''
    end

    def invalid_attribute(name)
      "Invalid Scale API #{name} (current value: `#{fetch_attribute name}`). Please, set a valid `#{name}` parameter"
    end

  end
end
