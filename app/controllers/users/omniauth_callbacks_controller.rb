# frozen_string_literal: true
# facebook、googleが提供しているリソースサーバーからの応答をコールバックとして受け取って処理する
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #sigu_up/indexのfacebookを押すと、facebookページへ飛んだ後、こちらにコールバックされる
  def facebook
    # :facebookはdevise.rbに保存されたキーデータ
    callback_for(:facebook)
  end
  #sign_up/indexのgoogleを押すと、googleページへ飛んだ後、こちらにコールバックされる
  def google_oauth2
    # :googleはdevise.rbに保存されたキーデータ
    callback_for(:google)
  end

  #コールバック関数
  def callback_for(provider)
    #OmniAuthで取得した全ての情報がrequest.env['omniauth]というハッシュ格納されている
    @omniauth = request.env['omniauth.auth']
    #Userモデルに定義したfind_oauthメソッドが呼ばれる
      #find_oauthメソッドは、OmniAuthで取ってきたデータをDBに保存したり、何も登録していない時には新しいインスタンスを作成する。
    info = User.find_oauth(@omniauth)
    #User情報を取り出して、@userへ代入 → sessionの生成
    @user = info[:user]
    
    #persisted?はオブジェクトがDBに保存済みかどうか判定するメソッド。保存済みならtrueを返す。
      #@userがDBに保存済みの場合(userが登録済みでfind_oauthメソッドでsnscredentialのみ作成された場合)
    if @user.persisted?
      #ログインする
      sign_in_and_redirect @user, event: :authentication
      #capitalizeメソッドで先頭の文字だけを大文字にする
      #is_navigational_format?メソッドは、フラッシュメッセージの有無を確認するもの
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    #userがDBに未登録の場合(find_oauthメソッドでsnscredentialとuserインスタンスが返ってきた場合)
    else
      #@snsにfind_oauthで作成されたsnscredentialインスタンスを代入 → sessionの生成
      @sns = info[:sns]
      session[:provider] = @sns[:provider]
      session[:uid] = @sns[:uid]
      render template: "devise/registrations/step1" 
    end
  end

  def failure
    redirect_to root_path and return
  end
end
