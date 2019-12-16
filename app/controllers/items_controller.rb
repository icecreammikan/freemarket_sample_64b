class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to item_path  #仮置き
      # notice: 'Event was successfully created.'
    else
      # 戻り値がfalseなので失敗
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  
  
  
  private
  def set_item
    @item = Item.find(params[:id])
  end
  
  def  item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :condition_id, :prefecture_id, :sendingmethod_id, :postageburden_id, :shippingday_id, :price, :profit, images_attributes:[:id, :image_url]).marge(seller_id: current_user.id,buyer_id: current_user.id)
  end
end
