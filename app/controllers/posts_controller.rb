class PostsController < ApplicationController
  include PaginationHelper
  include Api::V1::Post

  before_action :find_posts, only: [:index]
  before_action :find_post, only: [:show, :update, :edit]

  def index
    respond_to do |format|
      format.json do
        render json: pagination_json(@posts, :posts_json, params[:include] || {}), status: :ok
      end
      format.html do
      @posts = @posts.paginate pagination_help
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      format.html do
        if @post.update post_params
          flash[:success] = 'Post Updated!'
          redirect_to @post
        else
          render 'new'
        end
      end
      format.json do
        if @post.update post_params
          render json: @post, status: :ok
        else
          render json: { errors: @post.errors.full_messages }, status: :bad_request
        end
      end
    end
  end

  def new
    @post ||= Post.new
  end

  def create
    @post ||= Post.new post_params
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post created!'
          redirect_to @post
        else
          render 'new'
        end
      end
      format.json do
        if @post.save
          render json: @post, status: :ok
        else
          render json: { errors: @post.errors.full_messages }, status: :bad_request
        end
      end
    end
  end

  def find_posts
    @posts = Post.active
  end

  def find_post
    @post = Post.find params[:id] || params[:post_id]
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :state, :post_image)
  end
end
