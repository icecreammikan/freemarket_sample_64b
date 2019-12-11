class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(name:     auth.info.name,
                          provider: auth.provider,
                          uid:      auth.uid,
                          email:    auth.info.email,
                          token:    auth.credentials.token,
                          password: Devise.friendly_token[0, 20])
    end
    user
  end

  # Associations
  has_many :sns_credentials, dependent: :destroy
  has_many :cards,dependent: :destroy
  belongs_to_active_hash :birthyear
  belongs_to_active_hash :birthmonth
  has_one :user_address
  accepts_nested_attributes_for :user_address, allow_destroy: true

  # Validations
  validates :nickname,
            :email,
            :password,
            :last_name,
            :first_name,
            :last_name_kana,
            :first_name_kana,
            :birthyear_id,
            :birthmonth_id,
            :birthday, 
            :phone_number, presence: true

  validates :nickname, length: { maximum: 20 }
  validates :email, :phone_number, uniqueness:true
  # 英語と数字を最低1文字ずつ含まなければならない

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i}
  # 全角の漢字のみOK
  validates :last_name, :first_name, format: { with: /\A[一-龥]+\z/}
  # 全角カタカナのみ
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  
  validates :phone_number, format: {with: /\A\d{10,11}\z/ }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  #sms_confirmed
  validates :authentication_number, presence: true, numericality: { only_integer: true }


  #omniauth認証メソッド
  #snscredentialに認証情報が無い場合
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      #Userが登録済みでSNS認証されていない場合、snscredentialデータを作成する
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      #Userが未登録かつSNS認証されていない場合、Userインスタンスを作成し、かつSnsCredentialインスタンスを作成する
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user, sns: sns }
  end
  
  #snscredentialに認証情報がある場合
  def self.with_sns_data(auth, snscredential)
    #snscredentialのuser_idデータに基づいてUserを検索
    user = User.where(id: snscredential.user_id).first
    #Userが存在しない場合、認証情報に基づいてUserインスタンスを作成する
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email
      )
    end
    return { user: user}
  end
  
    #引数authにはcollbackコントローラからOmniAuthで取得した情報が渡される
  def self.find_oauth(auth)
    #OmniAuth情報からuid, provider情報をそれぞれ取り出す
    uid = auth.uid
    provider = auth.provider
    #取り出した情報を元に、SnsCredentialテーブルからユーザーを検索する
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    #snscredentialテーブルに情報があったか場合分けをする
    if snscredential.present?
      #snscredentialにデータが存在する場合は、with_sns_dataへauth情報を渡す
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      #snscredentialにデータが存在しない場合は、without_sns_dataへauth情報を渡す
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user, sns: sns }
  end
end
