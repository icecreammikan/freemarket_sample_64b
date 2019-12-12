class UserAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Associations
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  #Validations
  validates :a_last_name,
            :a_first_name,
            :a_last_name_kana,
            :a_first_name_kana,
            :postcode,
            :prefecture_id,
            :city,
            :address, presence: true
  
  validates :postcode, length: { is: 7 }, format: { with: /\A\d{7}\z/ }
  # 全角の漢字のみOK
  validates :a_last_name, :a_first_name, format: { with: /\A[一-龥]+\z/}
  # 全角カタカナのみ
  validates :a_last_name_kana, :a_first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
end
