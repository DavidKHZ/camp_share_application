class OffersController < ApplicationController
  # to be done : index show new create edit update
  def index
    @offers = Offer.all
    @offers = @offers.where(category: params[:category]) if params[:category]
    @offers = @offers.where(city: params[:city]) if params[:city]
    @offers = @offers.where(country: params[:country]) if params[:country]
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user

    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(
      :name,
      :category,
      :pick_up_from,
      :pick_up_till,
      :return_from,
      :return_till,
      :country,
      :state,
      :city,
      :postcode,
      :address_1,
      :address_2,
      :description,
      :available,
      :price_per_day,
      :photos
      )
  end
end
