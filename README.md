# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Mercari DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, limit: 15|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false, limit: 50|
|last_name|string|null: false, limit: 50|
|first_name_kana|string|null: false, limit: 50|
|last_name_kana|string|null: false, limit: 50|
|phone_number|integer|null: false, limit: 50, unique: true|
|birthyear_id|reference|null: false, foreign_key: true|
|birthmonth_id|reference|null: false, foreign_key: true|
|birthday|integer|null: false|
|icon|text|null: false|
|header_image|text|null: false|
|introduce|text||
|prefecture_id|reference|null: false|
|city|text|null: false|
|address|text|null: false|
|building_name|text||
|send_phone_number|integer||

### Association
has_many :items
has_many :comments
has_many :messages
has_many :sns_credentials, dependent: :destroy
has_many :buyed_item, forign_key: ”buyer_id”, class_name: ‘Item’
has_many :selling_item, -> { where(“buyer_id is NULL") }, foreign_key: “seller_id", class_name: “Item”
has_many :sold_item, -> { where(“buyer_id is not NULL") }, foreign_key: “seller_id", class_name: “Item”
belongs_to_active_hash :prefecture
belongs_to_active_hash :birthyear
belongs_to_active_hash :birthmonth

## sns_credentialsテーブル
|uid|string||
|provider|string||
|user_id|reference|foreign_key: true|

### Association
belongs_to :user, optional: true

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|seller_id|reference|null: false, foreign_key: true|
|buyer_id|reference|null: false, foreign_key: true|
|name|string|null: false, add_index: true|
|description|string|null: false|
|category_id|reference|null: false, foreign_key: true|
|size_id|reference|null: false, foreign_key: true|
|brand_id|reference|null: false, foreign_key: true|
|condition_id|reference|null: false, foreign_key: true|
|prefecture_id|reference|null: false, foreign_key: true|
|sendingmethod_id|reference|null: false, foreign_key: true|
|postageburden_id|reference|null: false, foreign_key: true|
|shippingday_id|reference|null: false, foreign_key: true|
|price|integer|null: false|
|profit|integer|null: false|

### Association
has_many :images, dependent: :destroy
accepts_nested_attributes_for :images, allow_destroy: true
has_many :comments
belongs_to :buyer, class_name: 'User', optional: true
belongs_to :seller, class_name: 'User'
belongs_to :category
belongs_to :size
belongs_to :brand
belongs_to_active_hash :prefecture
belongs_to_active_hash :condition
belongs_to_active_hash :sendingmethod
belongs_to_active_hash :postageburden
belongs_to_active_hash :shippingday
belongs_to :transaction


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|text|null: false, add_index: true|

### Association
has_many: items
has_many: ancestry
has_many: brands, through: :category_brands
has_many: category_brands


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|text|null: false, add_index: true|

### Association
has_many :items
has_many :categories, through: :category_brands
has_many :category_brands


## category_brandsテーブル
|Column|Type|Options|
|------|----|-------|
|category_id|reference|null: false, foreign_key: true|
|brand_id|reference|null: false, foreign_key: true|

### Association
belongs_to :category
belongs_to :brand


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|image_url|text|null: false|

### Association
belongs_to :item, optional: true


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :item


## transactionsテーブル
|item_id|reference|null: false, foreign_key: true|

### Association
has_one: item
has_many: messages

## messagesテーブル
|content|string|null: false|
|transaction_id|reference|null: false, foreign_key: true|
|user_id|reference|null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :transaction



### ActiveHashes

## birthyearsテーブル
|Column|Type|Options|
|------|----|-------|
|name|integer||

## birthmonthsテーブル
|Column|Type|Options|
|------|----|-------|
|name|integer||

## prefecturesテーブル
|------|----|-------|
|name|string|null: false|

## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

## sendingmethodsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

## postageburdensテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

## shippingdaysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||