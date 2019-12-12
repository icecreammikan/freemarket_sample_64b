require 'rails_helper'

RSpec.describe UserAddressController, type: :controller do
  #変数userにfactoriesに基づいて作成されたuserデータを代入
  let(:user){create(:user)}

  describe 'GET #step4' do
    it "住所登録ページに遷移するか" do
      login_user user
      get :step4
      #get :step4の遷移先viewがresponseに入る
      expect(response).to render_template :step4
    end
  end

  describe 'POST #create' do
    let(:params){{user_id: user.id, user_address: attributes_for(:user_address)}}
    context 'ログインする' do
      before do
        login_user user
      end

      context '住所登録ができる' do
        subject {
          post :create,
          params: params
        }
        it '住所登録ができる' do
          expect{ subject }.to change(UserAddress, :count).by(1)
        end

        it 'カード登録ページに遷移する' do
          subject
          expect(response).to redirect_to(card_new_path)
        end
      end

      context '住所登録ができない' do
        let(:invalid_params){{user_id: user.id, user_address: attributes_for(:user_address, postcode: nil)}}
        subject {
          post :create,
          params: invalid_params
        }

        it 'ユーザーアドレスが保存されない' do
          expect{ subject }.not_to change(UserAddress, :count)
        end

        it 'step4のページに戻る' do
          subject
          expect(response).to render_template :step4
        end
      end
    end

    context 'not log in' do
      it 'ログインページへ遷移する' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end