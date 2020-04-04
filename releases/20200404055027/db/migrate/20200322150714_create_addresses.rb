class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :postcode
      t.string :prefecture
      t.string :city
      t.string :block
      t.string :building
      t.string :phone_number
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
