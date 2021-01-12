class DashboardController < ApplicationController

    def index

        if session[:user_id] == nil
            redirect_to '/'
            return
        end
        
        user = helpers.get_user(session[:user_id])
        
        if user.nil? 
            redirect_to '/'
            return
        end

        @username = user.username
    end
    
end
