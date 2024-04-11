
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home; end

  def dashboard
    @submitted_bookings = current_user.bookings
    @provided_bookings = current_user.provided_bookings
    @offers = user.offers
  end
end
