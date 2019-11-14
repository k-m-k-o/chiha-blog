class TagsController < ApplicationController
  def index
    @posts = Post.where(posted: true).includes(:admin)
    @tags = []
    @posts.each do |post|
      tags = post.tags
      @tags << tags
    end
    @tags.flatten!.uniq! if @tags.length != 0
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.where(posted: true).includes(:admin).order("created_at DESC").page(params[:page]).per(15)
    if @posts.nil?
      redirect_to tags_path 
      return false
    end
  end
end
