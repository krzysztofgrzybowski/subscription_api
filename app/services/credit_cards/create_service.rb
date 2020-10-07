module CreditCards
  # Service to create credit card record
  # params: [:expiration_month, :expiration_year, :zip_code, :token, :last_digits]
  class CreateService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      credit_card = CreditCard.create(@params)
      if credit_card
        success(id: credit_card.id)
      else
        failure(credit_card.errors)
      end
    end
  end
end
