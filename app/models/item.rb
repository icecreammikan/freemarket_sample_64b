class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true   #仮置き
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :brand_id, optional: true
  has_many :messages
  mount_uploader :image, ImageUploader
  # has_many :coments, optional: true
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postageburden
  belongs_to_active_hash :shippingday
  belongs_to_active_hash :sendingmethod

  validates :seller_id,
            :image,
            :name,
            :description,
            :category_id,
            :condition_id,
            :prefecture_id,
            :sendingmethod_id,
            :postageburden_id,
            :shippingday_id,
            :price,
            :profit, presence: true

  #価格は7桁まで
  validates :price,:profit, length: {maximum: 7}

  belongs_to :category

  #モデルメソッド
  #特定のレコードの前後レコードを取得
  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

end
