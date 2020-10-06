class CreditCard < ApplicationRecord
  validates :last_digits, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :zipcode, presence: true
  validates :token, presence: true
end
