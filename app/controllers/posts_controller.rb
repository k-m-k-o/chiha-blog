class PostsController < ApplicationController 
  before_action :redirect_top_page,except: [:show,:all, :fishing, :audio, :tech, :others]
  def show

  end

  def all
    @posts = Post.all.includes(:admin).order("updated_at DESC")
  end

  def fishing
    @posts = Post.where(category: "Fishing",posted: true).order("updated_at DESC")
  end

  def audio
    @posts = Post.where(category: "Audio",posted: true).order("updated_at DESC")
  end

  def tech
    @posts = Post.where(category: "Tech",posted: true).order("updated_at DESC")
  end

  def others
    @posts = Post.where(category: "Others",posted: true).order("updated_at DESC")
  end

  #以下admin用

  def index
    @posts = Post.all.order("updated_at DESC")
    render layout: 'admin'
  end

  def edit
    @post = Post.find(params[:id])
    render layout: 'admin'
  end

  def new
    @post = Post.new
    render layout: 'admin'
  end

  def create
    @post = Post.find_or_initialize_by(title: post_params[:title],category: post_params[:category])
    post_params[:posted] == "0" ? posted = false : posted = true
    if @post.new_record?
      @post = current_admin.posts.new(
        thumb: post_params[:thumb],
        body: post_params[:body],
        title: post_params[:title],
        posted: posted, 
        category: post_params[:category]
      )
      if @post.save
        tag_arr = params[:name].split(",")
        binding.pry
        tag_arr.each do |name|
          new_tag = Tag.find_or_initialize_by(name: name)
          new_tag.save if new_tag.new_record?
          tag_post = PostTag.find_or_create_by(post_id: @post.id,tag_id: new_tag.id)
        end
        redirect_to admin_posts_path
      else
        render "posts/new"
      end
    elsif @post.update_attributes(body: post_params[:body],posted: posted,thumb: post_params[:thumb])
      redirect_to admin_posts_path(current_admin)
    else
      render "posts/new"
    end
  end

  def update
    @post = Post.find(params[:id])

    post_params[:posted] == "0" ? posted = false : posted = true
    if @post.present? && post_params[:thumb].present? && @post.update_attributes(body: post_params[:body],posted: posted,thumb: post_params[:thumb],category: post_params[:category],title: post_params[:title])
      if params[:name].present?
        tag_arr = params[:name].split(",")
        tag_arr.each do |name|
          new_tag = Tag.find_or_initialize_by(name: name)
          new_tag.save if new_tag.new_record?
          tag_post = PostTag.find_or_create_by(post_id: @post.id,tag_id: new_tag.id)
        end
      end
      redirect_to admin_posts_path(current_admin)
    elsif @post.present? && @post.update_attributes(body: post_params[:body],posted: posted,category: post_params[:category],title: post_params[:title])
      if params[:name].present?
        tag_arr = params[:name].split(",")
        tag_arr.each do |name|
          new_tag = Tag.find_or_initialize_by(name: name)
          new_tag.save if new_tag.new_record?
          tag_post = PostTag.find_or_create_by(post_id: @post.id,tag_id: new_tag.id)
        end
      end
      redirect_to admin_posts_path(current_admin)
    else
      render "posts/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post && signed_in?
      @post.delete
    end
    redirect_to admin_posts_path(current_admin)
  end

  def autosave
    if request.xhr?
        @post = Post.find_by(id: post_params[:category])
        if @post
          @post.update_attributes(body: post_params[:body],title: post_params[:title])
          render partial: 'markdown', locals: {post: @post}
        else
          return false
        end
    end
  end
  
  def search
    @search = Post.ransack(params[:q])
    @posts = @search.result
    render layout: 'admin'
  end

  def writing
    @posts = Post.where(posted: false).order("updated_at DESC")
    render layout: 'admin'
  end

  def posted
    @posts = Post.where(posted: true).order("updated_at DESC")
    render layout: 'admin'
  end

  private

  def redirect_top_page
    redirect_to root_path unless signed_in?
  end

  def post_params
    params.require(:post).permit(:title,:posted,:body,:thumb,:category)
  end

end