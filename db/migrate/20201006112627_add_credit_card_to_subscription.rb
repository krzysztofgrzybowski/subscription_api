class AddCreditCardToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscriptions, :credit_card, foreign_key: true
  end
end
