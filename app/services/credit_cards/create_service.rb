module CreditCards
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
