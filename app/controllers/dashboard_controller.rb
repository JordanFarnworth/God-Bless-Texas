class DashboardController < ApplicationController
  skip_before_action :check_session
  def signup

  end

  def index
    respond_to do |format|
      format.html do
        redirect_to posts_path
      end  
    end
  end
end
