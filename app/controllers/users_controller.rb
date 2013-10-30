class UsersController < ApplicationController

  skip_before_filter :require_login

  def index
    @users = User.paginate page: params[:page]||1, per_page: 10
  end

  def new
    @user = User.new
  end
  
  def create
    user = User.new(params[:user])
    if user.save
      set_current_user(user)
      redirect_to root_path
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to users_path if @user.destroy
  end


end
