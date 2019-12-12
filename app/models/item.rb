class Item < ApplicationRecord
  has_many :images
  belongs_to :user
  # has_many :coments
  # has_many :messages
  # belongs_to :category
  # belongs_to :brand
end
