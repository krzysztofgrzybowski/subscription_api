class CreateSubscriptionPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
