class SubscriptionPlansController < ApplicationController
  def index
    render json: SubscriptionPlan.all
  end
end
