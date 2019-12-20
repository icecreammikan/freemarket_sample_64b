class ItemsController < ApplicationController
# before_action :set_item
before_action :authenticate_user!, only: [:new, :create, :buy, :pay]
  
  require 'payjp'

  def index
    @ladys      = Item.all.order(id:"desc").where(category_id:1).limit(10)
    @mans       = Item.all.order(id:"desc").where(category_id:2).limit(10)
    @appliances = Item.all.order(id:"desc").where(category_id:8).limit(10)
    @toys       = Item.all.order(id:"desc").where(category_id:6).limit(10)
    @chanels    = Item.all.order(id:"desc").where(category_id:14).limit(10)
    @vuittons   = Item.all.order(id:"desc").where(category_id:15).limit(10)
    @supremes   = Item.all.order(id:"desc").where(category_id:16).limit(10)
    @nikes      = Item.all.order(id:"desc").where(category_id:17).limit(10)
    # categoly_idはそれぞれ該当のidへ書き換えてください
  end

  def new
    @item = Item.new
    @images = @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.price.present?
      @item.profit = @item.price * 0.9
    end
    if @item.save
      redirect_to mypage_index_path
    else
      @item.images.build
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.seller_id)
    @items = Item.where(seller_id: @item.seller_id)
    @maxid = Item.maximum(:id)
    @minimumid = Item.minimum(:id)

    if @item.id != @maxid
      id1 = params[:id].to_i + 1
      @item1 = Item.find(id1)
    end

    if @item.id != @minimumid
      id2 = params[:id].to_i - 1
      @item2 = Item.find(id2)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to  mypage_index_path
    else
      redirect_to  edit_item_path(@item.id)
      :javascript
        alert('削除できませんでした。');
    end
  end


  def buy
    @card = Card.find_by(user_id: current_user.id)
    # Cardテーブルからpayjpの顧客IDを検索
    @item = Item.find(params[:id])
    if @card.blank?
      redirect_to controller: "card", action: "step5"
      #登録された情報が無い場合にカード登録画面に移動
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管した顧客IDでpayjpから情報取得
      @default_card_information = customer.cards.retrieve(@card.card_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    end
  end

  def pay
    @card = Card.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy'
    )
    redirect_to action: 'done'
  end

  def done
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def  item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :size_id,
      :brand_id,
      :condition_id,
      :prefecture_id,
      :sendingmethod_id,
      :postageburden_id,
      :shippingday_id,
      :price,
      images_attributes: [:image_url]).merge(seller_id: current_user.id,)
  end

end
