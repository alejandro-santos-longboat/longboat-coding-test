class DashboardController < ApplicationController

    def index

        if session[:user_id] == nil
            redirect_to '/'
            return
        end
        
        @username = helpers.get_username(session[:user_id])
    end
    
end
