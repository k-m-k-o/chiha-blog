class Post < ApplicationRecord

  mount_uploader :thumb, ThumbUploader

  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  belongs_to :admin
  is_impressionable
end
