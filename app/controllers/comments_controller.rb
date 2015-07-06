class CommentsController < ApplicationController
  include PaginationHelper
  include Api::V1::Comment

  before_action :find_post_comments, only: :post_comments
  before_action :find_user_comments, only: :user_comments

  def post_comments
    respond_to do |format|
      format.json do
        render json: pagination_json(@post_comments, :comments_json, params[:include] || {})
      end
    end
  end

  def user_comments
    respond_to do |format|
      format.json do
        render json: comments_json(@user_comments, includes)
      end
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      respond_to do |format|
        format.json do
          if @comment.save
            render json: @comment, status: :ok
          else
            render json: { errors: @comment.errors.full_messages }, status: :bad_request
          end
        end
      end
    end
  end

  def destroy

  end

  def find_post_comments
    @post = Post.find params[:id]
    @post_comments = @post.comments
  end

  def find_user_comments
    @user = User.find params[:id]
    @user_comments = @user.comments
  end


  private
  def comment_params
    params.require(:comment).permit(:id, :post_id, :state, :user_id, :message)
  end
end
