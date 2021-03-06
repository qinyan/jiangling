class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user
  before_filter :require_login

  def user_for_paper_trail
    'Unknown user'
  end

  def set_current_user(user)
    session[:uid] = user.id
  end

  def get_current_user
    @current_user = User.find(session[:uid]) rescue nil
  end

  def require_login
    redirect_to root_path  unless @current_user
  end

end
