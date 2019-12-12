class CardController < ApplicationController
  before_action :authenticate_user!

  require "payjp"

  def step5
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if card_params['payjp-token'].blank?
        redirect_to action: "step5"
      else
        customer = Payjp::Customer.create(card: params['payjp-token']) 
        @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        if @card.save
          redirect_to controller: '/signup', action: 'done'
        else
          redirect_to({action: "step5"}, notice: 'カード情報を入れ直してください')
        end
    end
  end
end
