class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :customer, foreign_key: true
      t.references :subscription_plan, foreign_key: true
      t.integer :months_num
      t.integer :months_num_reference
      t.date :next_renewal_date
      t.date :renewal_date_reference
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
