module Subscriptions
  # Service used to process renewal payment for subscripion
  # params: [:subscription]
  class ProcessRenewal
    def initialize(subscription)
      @subscription = subscription
    end

    def call
      payment_result = Payments::ProcessService.new(
        token: @subscription.credit_card.token, amount: @subscription.subscription_plan.price_in_cents
      ).call

      if payment_result.success?
        on_payment_success
        success
      else
        on_payment_failure
        failure(payment_result.payload)
      end
    end

    private

    def on_payment_success
      @subscription.update(
        next_renewal_date: @subscription.renewal_date_reference + (@subscription.months_num_reference + 1).months,
        months_num: @subscription.months_num + 1,
        months_num_reference: @subscription.months_num_reference + 1
      )
    end

    def on_payment_failure
      @subscription.update(status: :on_hold)
    end
  end
end