class ViewController < ApplicationController
  def index
    @user = params[:user]
  end
end
