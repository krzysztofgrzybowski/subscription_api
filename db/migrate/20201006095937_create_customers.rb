class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
