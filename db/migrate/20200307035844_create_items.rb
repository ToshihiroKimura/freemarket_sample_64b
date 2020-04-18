class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name,             null: false
      t.text :text,               null: false
      t.string :item_status,      null: false
      t.integer :price,           null: false
      t.string :delivery_charge,  null: false
      t.integer :delivery_area,    null: false
      t.string :delivery_days,    null: false
      t.references :category,     null: false
      t.references :brand
      t.references :solder
      t.references :buyer
      t.timestamps
    end
  end
end
