class Address < ApplicationRecord
  validates :address1, presence: true
  validates :zipcode, presence: true
end
