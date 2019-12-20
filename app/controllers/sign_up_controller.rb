class SignUpController < ApplicationController
  before_action :authenticate_user!, only: [:done]
  def index
  end

  def done
  end
end
