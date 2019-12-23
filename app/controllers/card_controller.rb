class CardController < ApplicationController
  before_action :authenticate_user!

  require "payjp"

  def step5
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      if params['payjpToken'].blank?
        redirect_to action: "step5"
      else
        #payjpに保存する
        customer = Payjp::Customer.create(card: params['payjpToken'],
                                          metadata: {user_id: current_user.id}) 
        @card = Card.new(user_id: current_user.id,
                          customer_id: customer.id,
                          card_id: customer.default_card)
        if @card.save
          redirect_to controller: '/sign_up', action: 'done'
        else
          redirect_to({action: "step5"}, notice: 'カード情報を入れ直してください')
        end
      end
  end
end
