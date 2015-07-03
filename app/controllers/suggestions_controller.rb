class SuggestionsController < ApplicationController

  def index
    @suggestions = @current_user.suggestions.active
  end

  def new
    @suggestion ||= Suggestion.new
  end

  def create
    @suggestion ||= Suggestion.new suggestion_params
    @suggestion.user = @current_user
    respond_to do |format|
      format.html do
        if @suggestion.save
          flash[:success] = "Thank you for your suggestion! We will try and respond to you via email within 48 hours."
          redirect_to suggestion_path @suggestion
        end
      end
    end
  end

  def suggestion_params
    params.require(:suggestion).permit(:user, :message, :title, :state)
  end
end
