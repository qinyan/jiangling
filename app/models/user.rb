# encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  acts_as_global_primary_key
 # validates :username, :presence => { :message => '请输入中文姓名'}
 # validates :email, :presence => { :message => "请填写联系邮箱" }
 # validates :password, :confirmation => true, :presence => { :message => '请填写密码'}
  
  validates_presence_of :username, :email
  validates_presence_of :password, :on => :create
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_confirmation_of :password
  validates_uniqueness_of :username,  :email, :on => :create, :message => 'must be unique'
  validates :email, :email_format => true
  #validates_email :email
   
  has_one  :user_info
  has_one  :user_login
  has_many :user_auths, :class_name => 'UserLoginAuth'
end
