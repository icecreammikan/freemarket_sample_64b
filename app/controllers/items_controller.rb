class ItemsController < ApplicationController

  
  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.save!
    redirect_to item_path  #仮置き
  rescue
    render action: "new"
  end

  
  
  
  private
  def find_item
    @item = Item.find(params[:id])
  end
  
  def  item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :condition_id, :prefecture_id, :sendingmethod_id, :postageburden_id, :shippingday_id, :price, :profit, images_attributes:[:id, :image_url]).marge(seller_id: current_user.id,buyer_id: current_user.id)
  end
end
