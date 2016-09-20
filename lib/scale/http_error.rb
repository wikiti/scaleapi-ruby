module Scale
  class HttpError < GenericError
    attr_reader :original_exception, :code, :message, :response

    def initialize(exception)
      @original_exception = exception
      @response = Scale.hash(JSON.parse(exception.response.body)) rescue Scale.hash()
      @code = response[:status_code] || e.original_exception.response.code rescue 500
      @message = response[:message] || response[:error]
    end
  end
end
