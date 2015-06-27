class PostsController < ApplicationController
  include PaginationHelper
    include Api::V1::Post

  before_action :find_posts, only: [:index]
  before_action :find_post, only: [:show]

  def index
    respond_to do |format|
      format.json do
        render json: pagination_json(@posts, :post_json, params[:include] || {}), status: :ok
      end
      format.html do
        @posts = @posts.paginate pagination_help
      end
    end
  end

  def find_posts
    @posts = Post.active
  end

  def find_post
    @post = Post.active.find params[:id] || params[:post_id]
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :state)
  end
end
