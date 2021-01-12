class DashboardController < ApplicationController

    def index

        # If no current user in session, return to login page
        if session[:user_id] == nil
            redirect_to '/'
            return
        end
        
        # Try get user object with user id from session
        user = helpers.get_user(session[:user_id])
        
        # If no user found with user id
        if user.nil? 
            # Invalidate session
            session[:user_id] = nil
            # Return to login page
            redirect_to '/'
            return
        end

        @username = user.username
    end
    
end
