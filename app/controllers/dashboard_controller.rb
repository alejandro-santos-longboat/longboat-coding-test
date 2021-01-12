class DashboardController < ApplicationController

    def index
        @username = session[:user_id]
    end
    
end
