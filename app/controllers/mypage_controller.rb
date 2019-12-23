class MypageController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.find(current_user.id)
  end

  def card
  end

  def add
  end

  def identification
  end

  def profile
    @user = User.find(current_user.id)
  end

  def logout
  end

end
