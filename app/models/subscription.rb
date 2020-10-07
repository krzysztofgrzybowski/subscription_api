class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription_plan
  belongs_to :credit_card

  enum status: %i[active on_hold]

  scope :to_process, -> { where(next_renewal_date: Date.today) }
end
