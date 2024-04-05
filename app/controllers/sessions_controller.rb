class SessionsController < ApplicationController
    def after_sign_in_path_for(resource)
        home_path
    end
    def new
    end
end
