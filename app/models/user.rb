class User < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_global_primary_key
  has_one :user_email, :class_name => 'UserEmail'
  has_one :user_info, :class_name => 'UserInfo'
  has_many :user_auths, :class_name => 'UserLoginAuth'
end
