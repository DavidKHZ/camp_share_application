class BookingsController < ApplicationController
  before_action :retrieve_offer, only: %i[create update]

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      flash[:success] = "Booking was submitted successfully!"
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def retrieve_offer
    @offer = Offer.find(params[:offer_id])
  end

  def booking_params
    params.require(:booking).permit(
      :offer_id,
      :from,
      :to
      )
  end

end
