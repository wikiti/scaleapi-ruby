require 'helper'

class TestAPI < Test::Unit::TestCase
  context 'create a valid API handler' do
    should 'create an API object with default parameters' do
      assert_nothing_raised do
        Scale.setup api_key: scale.api_key
      end
    end
  end

  context 'create an API handler with an invalid token' do
    should 'raise an error' do
      assert_raise Scale::GenericError do
        Scale.setup api_key: ''
      end
    end
  end

  context 'create an API handler with an invalid endpoint' do
    should 'raise an error' do
      assert_raise Scale::GenericError do
        Scale.setup endpoint: 'invalid-url'
      end
    end
  end
end
