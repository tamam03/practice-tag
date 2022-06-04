class PostsController < ApplicationController
  
  def create
    @post = current_user.posts.new(post_params)
  end
  
  def index
  end
  
  def show
  end
  

  
end
