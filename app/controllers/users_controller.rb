class UsersController < ApplicationController
  include Api::V1::User
  include PaginationHelper

  skip_before_action :check_session, only: [:new, :create]

  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :find_users, only: [:index]

  def index
    @users = User.all
    respond_to do |format|
      format.json do
        render json: pagination_json(@users, :users_json, params[:include] || {}), status: :ok
      end
      format.html do
        @users.paginate pagination_help
      end
    end
  end

  def show
    @user = User.find params[:id]
  end

  def find_user
    @user = User.find params[:id]
  end

  def find_users
    @users = User.active
  end

  def new
    if logged_in?
      redirect_to :posts
    else
      @user =  User.new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user
      flash.clear
      flash[:success] = "#{@user.username} has been updated"
    else
      render 'edit'
    end
  end

  def signup
    @user = User.new user_params
    if @user.save
      key = SecurityHelper.get_session_key
      @user.login_sessions.create! key: SecurityHelper.sha_hash(key), expires_at: 1.week.from_now
      cookie_type[:_texas_app_key] = {
        value: key,
        expires: 1.week.from_now
      }
      flash.clear
      flash[:success] = "#{@user.username} has been created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      key = SecurityHelper.get_session_key
      @user.login_sessions.create! key: SecurityHelper.sha_hash(key), expires_at: 1.week.from_now
      cookie_type[:_texas_app_key] = {
        value: key,
        expires: 1.week.from_now
      }
      flash.clear
      flash[:success] = "#{@user.username} has been created"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def flash_message(method = 'update')
    flash[:success] = "New User <a class=\"link-color\" href=#{user_path(@user)}>#{@user.name}</a> #{method == 'update' ? 'updated' : 'created'}!".html_safe
  end

  def user_params
    params.require(:user).permit(:username, :email, :created_at, :state, :password, :avatar)
  end
end
