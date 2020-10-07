class Address < ApplicationRecord
  validates :address1, presence: true
  validates :zip_code, presence: true
end
