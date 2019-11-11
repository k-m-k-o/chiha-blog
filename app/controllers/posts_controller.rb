class PostsController < ApplicationController 
  before_action :redirect_top_page,except: [:show,:all, :fishing, :audio, :tech, :others]
  def show

  end

  def all

  end

  def fishing

  end

  def audio

  end

  def tech

  end

  def others
    
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
    @post = Post.find_or_initialize_by(title: params[:title],category: params[:category])
    params[:posted] == "0" ? posted = false : posted = true
    if @post.new_record?
      @post = current_admin.posts.new(
        thumb: params[:thumb],
        body: params[:body],
        title: params[:title],
        posted: posted, 
        category: params[:category]
      )
      if @post.save
        redirect_to admin_posts_path
      else
        render "posts/new"
      end
    elsif @post.update_attributes(body: params[:body],posted: posted,thumb: params[:thumb])
      redirect_to admin_posts_path(current_admin)
    else
      render "posts/new"
    end
  end

  def update
    @post = Post.find(params[:id])
    params[:posted] == "0" ? posted = false : posted = true
    if @post.present? && params[:thumb].present? && @post.update_attributes(body: params[:body],posted: posted,thumb: params[:thumb],category: params[:category],title: params[:title])
      redirect_to admin_posts_path(current_admin)
    elsif @post.present? && @post.update_attributes(body: params[:body],posted: posted,category: params[:category],title: params[:title])
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
        @post = Post.find_by(id: params[:picked_num])
        if @post
          @post.update_attributes(body: params[:body],title: params[:title])
          render partial: 'markdown', locals: {post: @post}
        else
          return false
        end
    end
  end
  
  def search
    
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


end