require 'test_helper'
require 'vcr'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_params = {
      subscription: {
        subscription_plan_id: 1,
        customer: {
          firstname: 'Firstname',
          lastname: 'Lastname',
          email: 'email@address.com',
          address: {
            address1: 'Somewhere 123',
            address2: '',
            zip_code: '1234'
          }
        },
        credit_card: {
          card_number: '4242424242424242',
          cvv: '123',
          expiration_month: '01',
          expiration_year: (Time.now.year + 1).to_s,
          zip_code: '1234'
        }
      }
    }
  end

  test 'should create db records with valid params' do
    VCR.use_cassette('fakepay_1') do
      post subscriptions_url, params: @valid_params
    end
    assert_response :success
    assert_equal Customer.count, 1
    assert_equal Address.count, 1
    assert_equal Subscription.count, 1
    assert_equal CreditCard.count, 1
  end

  test 'should return errors for invalid customer' do
    invalid_params = @valid_params.clone
    invalid_params[:subscription][:customer][:lastname] = ''
    post subscriptions_url, params: invalid_params
    assert_response :unprocessable_entity
    assert_equal response.body, { customer: { lastname: ["can't be blank"], address: {} } }.to_json
  end

  test 'should return errors for invalid address' do
    invalid_params = @valid_params.clone
    invalid_params[:subscription][:customer][:address][:address1] = ''
    post subscriptions_url, params: invalid_params
    assert_response :unprocessable_entity
    assert_equal response.body, { customer: { address: { address1: ["can't be blank"] } } }.to_json
  end

  test 'should return errors for invalid credit card number' do
    invalid_params = @valid_params.clone
    invalid_params[:subscription][:credit_card][:card_number] = '4242424242424241'
    VCR.use_cassette('fakepay_2') do
      post subscriptions_url, params: invalid_params
    end
    assert_response :unprocessable_entity
    assert_equal response.body, { credit_card: 'Invalid credit card number' }.to_json
  end

  test 'should return errors for invalid credit card cvv' do
    invalid_params = @valid_params.clone
    invalid_params[:subscription][:credit_card][:cvv] = '000'
    VCR.use_cassette('fakepay_3') do
      post subscriptions_url, params: invalid_params
    end
    assert_response :unprocessable_entity
    assert_equal response.body, { credit_card: 'CVV failure' }.to_json
  end

  test 'should not create db records for invalid data' do
    invalid_params = @valid_params.clone
    invalid_params[:subscription][:credit_card][:cvv] = '000'
    VCR.use_cassette('fakepay_3') do
      post subscriptions_url, params: invalid_params
    end
    assert_equal Customer.count, 0
    assert_equal Address.count, 0
    assert_equal Subscription.count, 0
    assert_equal CreditCard.count, 0
  end

  test 'creates one customer and two subscriptions for the same email' do
    VCR.use_cassette('fakepay_1') do
      post subscriptions_url, params: @valid_params
    end
    VCR.use_cassette('fakepay_1') do
      post subscriptions_url, params: @valid_params
    end
    assert_equal Customer.count, 1
    assert_equal Address.count, 1
    assert_equal Subscription.count, 2
    assert_equal CreditCard.count, 2
  end
end
