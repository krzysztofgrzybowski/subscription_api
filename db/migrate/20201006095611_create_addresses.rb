class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :zipcode

      t.timestamps
    end
  end
end
