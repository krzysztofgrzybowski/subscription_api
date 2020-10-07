module Subscriptions
  # Service to create subscription with all neccessary data - credit card, customer and his address
  # params: [
  #           :subscription_plan_id,
  #           credit_card: [:amount, :card_number: :cvv, :expiration_month, :expiration_year, :zip_code],
  #           customer: [:firstname, :lastname, :email, address: [:address1, :address2, :zip_code]]
  #         ]
  class CreateService < BaseService
    def initialize(params)
      @params = params
      @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
      @customer_params = params[:customer]
      @credit_card_params = params[:credit_card]
    end

    def call
      customer_service = Customers::CreateOrUpdateService.new(@customer_params)
      result = customer_service.validate
      return failure(result.payload) unless result.success?

      result = Payments::ProcessService.new(@credit_card_params.merge(amount: @subscription_plan.price_in_cents)).call
      return failure(result.payload) unless result.success?

      customer_id = customer_service.call.payload[:id]

      card_id = create_credit_card(result.payload[:token]).payload[:id]
      create_subscription(card_id, customer_id)

      success
    end

    private

    def create_credit_card(token)
      CreditCards::CreateService.new(
        @credit_card_params.slice(:expiration_month, :expiration_year, :zip_code)
                           .merge({ token: token, last_digits: @credit_card_params[:card_number].last(4) })
      ).call
    end

    def create_subscription(card_id, customer_id)
      Subscription.create(
        subscription_plan_id: @subscription_plan.id,
        credit_card_id: card_id,
        customer_id: customer_id,
        months_num: 1,
        months_num_reference: 1,
        status: :active,
        next_renewal_date: Date.today + 1.month,
        renewal_date_reference: Date.today
      )
    end
  end
end
