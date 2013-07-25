class UserController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end
  
  def create
    p params
    @user = User.new(params[:user])
    p @user
    if @user.save
    redirect_to users_path
    end
  end
end
