class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :solder, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images,dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true
 
  validates :name, :text, :item_status, :price, :delivery_charge, :delivery_area, :delivery_days, :category, presence: true
  validates :name, length: {maximum: 40}
  validates :text, length: {maximum: 1000}
  validates :price, format: { with: /\A[0-9]+\z/}
  validates :price,numericality: {
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 999999,}
  validates :images, length: { minimum: 1}
  validates :images, length: { maximum: 10}
  
end
