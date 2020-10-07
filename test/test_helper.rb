ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def check_count(amount)
    assert_equal Customer.count, amounr
    assert_equal Address.count, amount
    assert_equal Subscription.count, amount
    assert_equal CreditCard.count, amount
  end
end
