class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images, dependent: :destroy
  belongs_to :user, optional: true   #仮置き
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :brand_id, optional: true
  has_many :messages
  # has_many :coments, optional: true
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  accepts_nested_attributes_for :images, allow_destroy: true

end
