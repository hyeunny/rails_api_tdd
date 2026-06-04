class PostsController < ApplicationController
  def index
    render json: Post.all
  end

  def show
    post = Post.find_by(id: params[:id])
    if post
      render json: post
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
