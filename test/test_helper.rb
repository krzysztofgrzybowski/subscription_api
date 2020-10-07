ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'vcr'
require 'dotenv'
Dotenv.load('.env')

VCR.configure do |config|
  config.cassette_library_dir = './vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data('<FAKEPAY_TOKEN>') { ENV['FAKEPAY_API_KEY'] }
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end
