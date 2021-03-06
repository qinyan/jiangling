# coding: utf-8
class Group < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user, class_name: 'User', foreign_key: :from_id
  belongs_to :follow_user, class_name: 'User', foreign_key: :to_id
end
