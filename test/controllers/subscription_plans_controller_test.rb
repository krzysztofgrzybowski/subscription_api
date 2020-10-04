require 'test_helper'

class SubscriptionPlansControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get subscription_plans_url
    assert_response :success
  end

  test 'index should return all plans' do
    expected_response = [
      { id: 1, name: 'Bronze Box', price: '19.99' },
      { id: 2, name: 'Silver Box', price: '49.0' },
      { id: 3, name: 'Gold Box', price: '99.0' }
    ]
    get subscription_plans_url
    assert_equal response.body, expected_response.to_json
  end
end
