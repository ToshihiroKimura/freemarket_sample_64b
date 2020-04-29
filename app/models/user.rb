class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_one :credit_card
  has_one :address
  has_many :buy_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :seling_items, -> { where("buyer_id is NULL") }, foreign_key: "solder_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "solder_id", class_name: "Item"

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i

  validates :last_name,           presence: true
  validates :first_name,          presence: true
  validates :last_name_kana,      presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_kana,     presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :nickname,            presence: true
  validates :birthday,            presence: true
  validates :email,               presence: true, uniqueness: true
  validates :encrypted_password,  presence: true, format: { with: /\A(?=.*[^\d])+/, allow_blank: true}
end