class ItemsController < ApplicationController

  require 'payjp'

  def index
    @ladys      = Item.all.order(id:"desc").where(category_id:1).limit(10)
    @mans       = Item.all.order(id:"desc").where(category_id:2).limit(10)
    @appliances = Item.all.order(id:"desc").where(category_id:3).limit(10)
    @toys       = Item.all.order(id:"desc").where(category_id:4).limit(10)
    @chanels    = Item.all.order(id:"desc").where(category_id:5).limit(10)
    @vuittons   = Item.all.order(id:"desc").where(category_id:6).limit(10)
    @supremes   = Item.all.order(id:"desc").where(category_id:7).limit(10)
    @nikes      = Item.all.order(id:"desc").where(category_id:8).limit(10)
    # categoly_idはそれぞれ該当のidへ書き換えてください
  end

  def new
    @item = Item.new
    @images = @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.profit = @item.price * 0.9
    if @item.save
      redirect_to root_path  #仮置き
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
  end

  def update
  end

  def destroy
  end


  def buy
    @card = Card.where(user_id: current_user.id).first
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
    @card = Card.where(user_id: current_user.id).first
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
