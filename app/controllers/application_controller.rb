class ApplicationController < ActionController::Base
  # Ensure user authentication for all actions except home
  before_action :authenticate_user!
  
  # Skip authentication for the home action
  skip_before_action :authenticate_user!, only: :home
  
  # Permit additional parameters for Devise registration forms
  before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    
        # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end

    def home
    end
end
