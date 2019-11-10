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
      redirect_to admin_posts_path
    else
      render "posts/new"
    end
  end

  def update
    
  end

  def destroy

  end


  private

  def redirect_top_page
    redirect_to root_path unless signed_in?
  end

end
