# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  acts_as_global_primary_key
 # validates :username, :presence => { :message => '请输入中文姓名'}
 # validates :email, :presence => { :message => "请填写联系邮箱" }
 # validates :password, :confirmation => true, :presence => { :message => '请填写密码'}
  validates :username, presence: {message: '输入不能为空'}, uniqueness: {message: '名字已被占用'} 
  validates :email, presence: {message: ' 输入不能为空'}, uniqueness: {message: '邮箱已被占用'}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: '邮箱格式不正确' }
  validates :password, presence: {message: ' 输入不能为空'}, length: { maximum: 16, message: '请设置1-16位英文字母、数字、符号密码' }, confirmation: {message: '密码输入不一致'} 
  
  # validates_presence_of :username, :email
  # validates_presence_of :password, :on => :create
  # validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  # validates_length_of :password, :minimum => 4, :allow_blank => true
  # validates_confirmation_of :password
  # validates_uniqueness_of :username, :email, :on => :create, :message => 'must be unique'
  # validates :email, :email_format => true
  # validates_email :email  :user_info
  has_one  :user_login
  has_many :user_auths, :class_name => 'UserLoginAuth'
end
