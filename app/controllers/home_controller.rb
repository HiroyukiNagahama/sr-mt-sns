class HomeController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
    if user_signed_in?
      redirect_to "/event/index"
    else
      redirect_to "/users/login"
    end
  end

  def show
  end
end
