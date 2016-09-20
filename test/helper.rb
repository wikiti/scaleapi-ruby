require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'scale'

class Test::Unit::TestCase
  def scale
    @scale ||= Scale.setup api_key: (ENV['SCALE_API_KEY'] || 'test_abcdefghijklmopqrstuvwxyz'),
                           default_request_params: { callback_url: 'http://www.example.com/callback' }
  end
end

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = config.default_cassette_options.merge(
    match_requests_on: %i(method uri host path query body headers),
    record: :new_episodes
  )
end
