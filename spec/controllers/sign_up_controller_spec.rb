require 'rails_helper'

RSpec.describe SignUpController, type: :controller do
  #変数userにfactoriesに基づいて作成されたuserデータを代入

  describe 'GET #index' do
    it "indexページへ遷移するか" do
      get :index
      #get :step4の遷移先viewがresponseに入る
      expect(response).to render_template :index
    end

    it "doneページへ遷移するか" do
      get :done
      expect(response).to render_template :done
    end
  end
end