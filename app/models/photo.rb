class Photo < ActiveRecord::Base
  # attr_accessible :title, :body

  mount_uploader :avatar, PhotoAvatarUploader
  # attr_accessible :avatard
  # has_attached_file :avatar
  include Rails.application.routes.url_helpers

  def to_json_picture
    {
     'name' => read_attribute(:avatar),
     'size' => avatar.size,
     'url'  => avatar.url(:originals),
     'thumbnail_url' => avatar.url(:feed),
     'delete_url' => photo_path(self),
     'delete_type' => 'DELETE'
    }
  end
end
