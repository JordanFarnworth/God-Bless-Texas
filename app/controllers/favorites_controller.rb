class FavoritesController < ApplicationController

  before_action :find_post_favorites, only: [:update, :create, :create_favorite]

  def find_post_favorites
    @post = Post.find params[:id]
  end

  def create_favorite
    favorite = Favorite.where(user: @current_user, post: @post).first
    if favorite.nil?
      Favorite.create user: @current_user, post: @post
      render nothing: true, status: :no_content
    else
      favorite.destroy
      render nothing: true, status: :no_content
    end
  end

  def create
    f = Favorite.find_or_create_by(user: @current_user, post: @post)
    if f.save?
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end

  def update
    df = Favorite.where(user: @current_user, post: @post).first
    df.destroy
    post_path(@post)
  end

  private
  def favorite_params
    params.require(:favorite).permit(:post_id, :user_id)
  end

end
