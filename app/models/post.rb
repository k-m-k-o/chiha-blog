class Post < ApplicationRecord
  belongs_to :admin
  mount_uploader :thumb, ThumbUploader
  has_many :tags,through: :post_tags
  has_many :post_tags
end
