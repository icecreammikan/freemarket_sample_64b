class Item < ApplicationRecord
  has_many :images
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"
  # has_many :coments
  # has_many :messages
  # belongs_to :category
  # belongs_to :brand
  accepts_nested_attributes_for :images
end
