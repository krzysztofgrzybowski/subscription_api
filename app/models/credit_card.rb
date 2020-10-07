class CreditCard < ApplicationRecord
  validates :last_digits, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :zip_code, presence: true
  validates :token, presence: true
end
