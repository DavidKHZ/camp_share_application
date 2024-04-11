class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :initialize_search

    private

    def configure_permitted_parameters
        # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])

        # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
    end

    def initialize_search
      @search = Offer.new(offer_params_search) if params[:offer]
      @search = Offer.new(category: session[:category]) if session[:category]
      # @search = Offer.new(category: params[:category]) if params[:category]
      @search ||= Offer.new
    end

    def offer_params_search
      params.require(:offer).permit(
        :category,
        :city
        )
    end

end
