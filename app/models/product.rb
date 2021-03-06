# coding: utf-8
class Product < ActiveRecord::Base
  # attr_accessible :description, :name
  # acts_as_global_primary_key
  #has_paper_trail      版本管理
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :image, ProductUploader
  validates :name, presence: {message: '输入不能为空'}
end
