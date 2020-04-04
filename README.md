##  itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|item_status|string|null: false|
|price|integer|null: false|
|delivery_charge|string|null: false|
|delivery_area|string|null: false|
|delivery_days|string|null: false|
|category|references|null: false, foreign_key:true|
|brand|references|foreign_key:true|
|solder_id|integer|| #1
|buyer_id|integer|| #2
### Association
- has_many :images
- belongs_to :category
- belongs_to :brand
- belongs_to :solder, class_name: "User"
- belongs_to :buyer, class_name: "User"

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|nickname|string|null: false|
|email|string|null: false, unique:true|
|password|string|null: false,unique:true|
|birthday|date|null: false|
### Association
- has_many :items
- has_one :credit_card
- has_one :address
- has_many :buy_items, class_name: "Item", foreign_key: "buyer_id"
- has_many :seling_items, ->{where(buyer_id is NULL)}, class_name: "Item", foreign_key: "solder_id"
- has_many :sold_items, ->{where(buyer_id is not NULL)}, class_name: "Item",foreign_key: "solder_id"

### adressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key:true|
|postcode|integer|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|block|string|null:false|
|building|string|null:false|
|phone_number|string|
### Association
- belongs_to :user

### credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null:false, foreign_key:true|
|customer_id|string|null:false| #user_id??
|card_id|string|null:false| #payjp
### Association
- belongs_to :user
## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many :items
- has_ancestry

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
