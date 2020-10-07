class SubscriptionPlansController < ApplicationController
  # GET /subscription_plans
  # Used to retrieve all subscription plans available
  def index
    render json: SubscriptionPlan.all
  end
end
