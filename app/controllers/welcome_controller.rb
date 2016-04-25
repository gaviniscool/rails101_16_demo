class WelcomeController < ApplicationController
  def index
    # flash[:notice] = "hi"
    flash[:alert] = "night"
  end


end
