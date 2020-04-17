class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  belongs_to :solder, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images

  
  validates :name, :text, :item_status, :price, :delivery_charge, :delivery_area, :delivery_days, :category_id, presence: true
end
