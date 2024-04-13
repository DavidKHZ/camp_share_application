class BookingsController < ApplicationController
  before_action :retrieve_offer, only: %i[create]

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      flash[:success] = "Your booking for #{@offer.name} from #{@booking.from} till #{@booking.to} was successfully submitted !"
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_status
    @booking = Booking.find(params[:id])
    permitted_statuses = gen_permitted_statuses
    respond_to do |format|
      if permitted_statuses.include?(params[:new_status]) && @booking.update(status: params[:new_status])
        format.json { render :show, status: :ok, location: @offer }
      else
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
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

  def gen_permitted_statuses
    if
      (
        Date.today < @booking.from &&
        %w[accepted pending].include?(@booking.status) &&
        current_user == @booking.user
      )
      permitted_statuses = %w[cancelled]
    elsif (
            Date.today < @booking.from &&
            current_user == @booking.offer.user
          )
      if @booking.status == "accepted"
        permitted_statuses = %w[cancelled]
      elsif @booking.status == "pending"
        permitted_statuses = %w[accepted rejected]
      else
        permitted_statuses =[]
      end
    else
      permitted_statuses =[]
    end
    return permitted_statuses
  end

end
