# encoding: utf-8
class UserController < ApplicationController
  def index
    @user = User.new
  end
end
