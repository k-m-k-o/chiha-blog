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
    render layout: 'admin'
  end

  def edit
    render layout: 'admin'
  end

  def new
    render layout: 'admin'
  end

  def create
    
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
