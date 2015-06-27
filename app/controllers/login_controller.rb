class LoginController < ApplicationController

  skip_before_action :check_session

  def index
    if logged_in?
      redirect_to :posts
    end
  end

  def verify
    user = User.active.find_by(email: params[:email]).try(:authenticate, params[:password])
    unless user
      flash[:error] = 'Incorrect username or password'
      render 'index'
    else
      key = SecurityHelper.get_session_key
      user.login_sessions.create! key: SecurityHelper.sha_hash(key), expires_at: 1.week.from_now
      cookie_type[:_texas_app_key] = {
        value: key,
        expires: 1.week.from_now
      }
      flash.clear
      flash[:success] = "#{user.username} has been logged in"
      redirect_to :posts
    end
  end

  def logout
    ls = LoginSession.find_by key: SecurityHelper.sha_hash(cookie_type[:_texas_app_key])
    ls.destroy if ls
    cookies.delete :_texas_app_key
    flash[:notice] = 'You have been logged out.'
    redirect_to login_path
  end

end
