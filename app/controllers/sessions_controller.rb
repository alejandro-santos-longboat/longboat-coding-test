class SessionsController < ApplicationController
    
    def create
        return if !request.post?

        user = User.find_by(username:login_params[:username])
        if user && user.password == login_params[:password]
            if user.loging_failure_count < 3
                session[:user_id] = user.id
                redirect_to '/dashboard'
                user.loging_failure_count = 0
            else
                flash[:login_notice] = 'Too many failed logging attempts, please contact a site administrator.'
            end
        else 
            flash[:login_notice] = 'Invalid credentials; user does not exist or password is incorrect'
            redirect_to '/'
        end
    end

    def delete
        return if !request.post?
        
        flash[:login_notice] = "Logged out successfully"
        session[:user_id] = nil
        redirect_to '/'
    end

    private
        def login_params
            params.require(:login).permit(:username, :password)
        end

end
