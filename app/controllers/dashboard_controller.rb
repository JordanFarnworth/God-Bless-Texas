class DashboardController < ApplicationController

  before_action :posts_information

  def posts_information
    
  end

  def help

  end

  def index
    respond_to do |format|
      format.html do

      end
      format.json do

      end
    end
  end
end
