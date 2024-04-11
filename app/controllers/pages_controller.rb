
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home category]

  def home; end

  def category
    session[:category] = params[:category]
    redirect_to offers_path
  end

  def dashboard
    @submitted_bookings = current_user.bookings
    @provided_bookings = current_user.provided_bookings
    @offers = current_user.offers
  end
end
