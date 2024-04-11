
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    # @lists = List.all
  end
  def category
    @search = Offer.new(category: params[:category])
    raise
  end
end
