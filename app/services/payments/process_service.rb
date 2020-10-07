module Payments
  # Service to process payment using Fakepay gateway
  # params: [:amount, :card_number: :cvv, :expiration_month, :expiration_year, :zip_code]
  #     or: [:amount, :token]
  class ProcessService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      response = Fakepay::Client.new.payment_with_card(@params)

      return failure(credit_card: errors_message(response)) unless response['success']

      success(token: response['token'])
    end

    private

    def errors_message(response)
      Fakepay::ERRORS[response['error_code']]
    end
  end
end
