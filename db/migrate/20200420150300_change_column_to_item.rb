class ChangeColumnToItem < ActiveRecord::Migration[5.0]
  def change
    remove_index :items, :brand_id
  end
end
