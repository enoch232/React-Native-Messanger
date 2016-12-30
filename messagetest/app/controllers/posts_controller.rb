class PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  def show
  end

  def index
    @posts = Post.all
  end

  def create
  	@post = Post.new(title: "", text: params[:message][:text])
  	if @post.save
      ActionCable.server.broadcast "first_channel", message: @post[:text]
  	  render json: @post
  	else
      render json: @post.errors
  	end
  end
end
