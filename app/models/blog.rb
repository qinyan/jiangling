#coding utf-8
class Blog < ActiveRecord::Base
  # attr_accessible :title, :body
  # acts_as_global_primary_key
  belongs_to :user
  before_save :add_intro
  delegate :email, :to => :user

  def add_intro
    self.intro = self.content.gsub(/&nbsp;/, '').gsub(/<.*?>/, '').truncate(210, :omission=>'...') if self.content.present?
    # self.intro = self.content.squish.truncate(255, :omission=>'...') if self.content.present?
  end

end
