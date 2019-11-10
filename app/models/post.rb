class Post < ApplicationRecord
  belongs_to :admin
  mount_uploader :thumb, ThumbUploader
end
