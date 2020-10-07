class SubscriptionsController < ApplicationController
  def create
    result = Subscriptions::CreateService.new(subscription_params).call
    if result.success?
      render json: {}, status: :ok
    else
      render json: result.payload, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(
      :subscription_plan_id,
      customer: [
        :firstname,
        :lastname,
        :email,
        address: [:address1, :address2, :zip_code]
      ],
      credit_card: [:card_number, :cvv, :expiration_month, :expiration_year, :zip_code]
    )
  end
end
