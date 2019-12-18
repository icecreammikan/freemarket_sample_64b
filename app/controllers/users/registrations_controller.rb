# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  def step1
    @user = User.new
    #omniauthの情報を元に、ユーザー情報を特定。
    session[:provider] = session[:provider]
    session[:uid] = session[:uid]
  end
  
  def step2
    #step1で入力した値をsession保持
    session[:nickname] = params[:user][:nickname]
    session[:email] = params[:user][:email]
    session[:password] = params[:user][:password]
    session[:last_name] = params[:user][:last_name]
    session[:first_name] = params[:user][:first_name]
    session[:last_name_kana] = params[:user][:last_name_kana]
    session[:first_name_kana] = params[:user][:first_name_kana]
    session[:birthyear_id] = params[:user][:birthyear_id]
    session[:birthmonth_id] = params[:user][:birthmonth_id]
    session[:birthday] = params[:user][:birthday]
    session[:provider] = session[:provider]
    session[:uid] = session[:uid]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthyear_id: session[:birthyear_id],
      birthmonth_id: session[:birthmonth_id],
      birthday: session[:birthday],
      #入力前の情報はバリデーションに通る値を仮で入れておく
      phone_number: "12345678910",
      authentication_number: "1234"
    )
    render 'step1' unless @user.valid?
  end

  def step3
    #step2で入力した値をsession保持
    session[:phone_number] = params[:user][:phone_number]
    session[:provider] = session[:provider]
    session[:uid] = session[:uid]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthyear_id: session[:birthyear_id],
      birthmonth_id: session[:birthmonth_id],
      birthday: session[:birthday],
      phone_number: session[:phone_number],
      authentication_number: "1234"
    )
    render 'step2' unless @user.valid?
  end



  def create
    #oath認証の場合
    if session[:provider].present? && session[:uid].present?
      #passwordをDeviseのヘルパーメソッドで自動生成
      @user = User.new(
        nickname:session[:nickname],
        email: session[:email],
        password: session[:password],
        last_name: session[:last_name],
        first_name: session[:first_name],
        last_name_kana: session[:last_name_kana], 
        first_name_kana: session[:first_name_kana],
        birthyear_id: session[:birthyear_id],
        birthmonth_id: session[:birthmonth_id],
        birthday: session[:birthday],
        phone_number: session[:phone_number],
        authentication_number: params[:user][:authentication_number]
      )
      render 'step3' and return unless @user.valid?
      @user.icon = "default_icon.png"
      if @user.save
        #snscredentialデータを作成
        sns = SnsCredential.create!(
          user_id: @user.id,
          uid: session[:uid],
          provider: session[:provider]
        )
        sign_in(@user)
        bypass_sign_in(@user)
        redirect_to controller: '/user_address', action: 'step4'
      else
        render "step1"
      end
    #email認証の場合
    else
      @user = User.new(
        nickname:session[:nickname],
        email: session[:email],
        password: session[:password],
        last_name: session[:last_name],
        first_name: session[:first_name],
        last_name_kana: session[:last_name_kana],
        first_name_kana: session[:first_name_kana],
        birthyear_id: session[:birthyear_id],
        birthmonth_id: session[:birthmonth_id],
        birthday: session[:birthday],
        phone_number: session[:phone_number],
        authentication_number: params[:user][:authentication_number]
      )
      render 'step3' and return unless @user.valid?
      #ユーザーにデフォルトアイコンを設定。
      @user.icon = "default_icon.png"
      if @user.save
        #user情報をいったんデータベースへ保存し、住所情報の登録へ
        redirect_to controller: '/user_address', action: 'step4'
        sign_in(@user)
        bypass_sign_in(@user)
      else
        render "step1"
      end
    end

  end
  private


  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :remember_me]
  end
end
