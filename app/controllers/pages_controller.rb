
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    # @lists = List.all
  end
  def category
    @category = params[:format]
    @offer = Offer.where(category:@category)
  end
end
