class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription_plan

  validates :zipcode, presence: true

  enum status: %i[active on_hold]
end
