require 'uri'
require 'date'

require 'scale/api'
require 'scale/generic_error'

module Scale
  def self.setup(params = {})
    Scale::API.new params
  end
end
