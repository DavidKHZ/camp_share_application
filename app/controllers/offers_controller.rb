class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :retrieve_offer, only: %i[show edit update]

  # to be done : index show new create edit update
  def index
    @offers = Offer.all
    @offers = @offers.where(category: @search.category) if @search.category.present?
    @offers = @offers.where(city: @search.city) if @search.city.present?
  end

  def show; end

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

  def edit; end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def retrieve_offer
    @offer = List.find(params[:id])
  end

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
