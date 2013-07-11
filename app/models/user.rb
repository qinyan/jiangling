# encoding: utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_global_primary_key
  validates :username, :presence => { :message => '请输入中文姓名'}
  validates :email, :presence => { :message => "请填写联系邮箱" }
  validates :password, :confirmation => true, :presence => { :message => '请填写密码'}
   
  has_one  :user_info
  has_one  :user_login
  has_many :user_auths, :class_name => 'UserLoginAuth'
end
