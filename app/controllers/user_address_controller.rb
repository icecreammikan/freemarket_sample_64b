class UserAddressController < ApplicationController
  before_action :authenticate_user!
  def step4
    @user_address = UserAddress.new
  end

  def create
    @user_address = UserAddress.new(user_address_params)
    if @user_address.save
      redirect_to controller: '/card', action: 'step5'
    else
      render 'step4'
    end
  end

  def update
  end

  private

  def user_address_params
    params.require(:user_address).permit(
      :a_last_name,
      :a_first_name,
      :a_last_name_kana,
      :a_first_name_kana,
      :postcode,
      :prefecture_id,
      :city,
      :address,
      :building_name,
      :send_phone_number
    ).merge(user_id: current_user.id)
  end
end
