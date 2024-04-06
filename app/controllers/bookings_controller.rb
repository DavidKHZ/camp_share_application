class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
