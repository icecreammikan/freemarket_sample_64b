Rails.application.routes.draw do
  #top_pageのindex画面のルーティング
  root 'items#index'

  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }


  #itemsの仮root<<<<<<< 商品出品のサーバサイド

  resources :items, except: :index do
    collection do
      get 'buy/:id', to: 'items#buy'
      post 'pay/:id', to: 'items#pay'
      get 'done/:id', to: 'items#done'
    end
  end


  #仮置き
  get 'posts', to: 'posts#index'


  devise_scope :user do
    get 'users/sign_up/registration',  to: 'users/registrations#step1'
    get 'users/sign_up/sms_confirmation',  to: 'users/registrations#step2'
    get 'users/sign_up/sms_confirmed', to: 'users/registrations#step3'
  end

  #sign_upのindexとdone画面のルーティング
  get '/sign_up/index', to: 'sign_up#index'
  get '/sign_up/done', to: 'sign_up#done'

  #住所の登録と変更のためのルーティング
  resources :user_address,only:[:create,:update]
  get '/user_address/new', to: 'user_address#step4'

  #カード登録と変更のためのルーティング
  resources :card, only: [:create]
  get '/card/new', to: 'card#step5'

  #mypage関連のルーティング
  get '/mypage/index', to: 'mypage#index'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/add_card', to: 'mypage#add'
  get '/mypage/identification', to:'mypage#identification'
  get '/mypage/profile', to: 'mypage#profile'
  get '/mypage/logout', to: 'mypage#logout'
end
