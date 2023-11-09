class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = User.find(params[:id]).posts
  end

  def show
    @post = User.find(params[:id]).posts.find(params[:post_id])
  end
end
