
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home category]
  def home
    # @lists = List.all
  end
  def category
    session[:category] = params[:category]
    redirect_to offers_path
  end
end
