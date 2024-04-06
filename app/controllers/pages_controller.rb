class PagesController < ApplicationController
  def dashboard
    @user=current_user
  end
  def listings
    @products = current_user&.products || []
  end
end
