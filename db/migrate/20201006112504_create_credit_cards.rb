class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :last_digits
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :zip_code
      t.string :token

      t.timestamps
    end
  end
end
