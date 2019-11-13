class TopPageController < ApplicationController
  def index
    @new_posts = Post.where(posted: true).order("updated_at DESC").limit(5)
  end
end
