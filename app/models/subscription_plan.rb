class SubscriptionPlan < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  
  def price_in_cents
    (price * 100).to_i
  end
end
