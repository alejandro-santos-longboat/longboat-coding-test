class LandingController < ApplicationController

    def login
        if session[:user_id] 
            redirect_to '/dashboard'
        end
    end

end
