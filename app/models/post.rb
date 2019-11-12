class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :admin
  mount_uploader :thumb, ThumbUploader
end
