class SessionsController < ApplicationController
    
    def create
        return if !request.post?
       
        user = User.get_user(login_params[:username])
        if !user.nil?
            if user.valid_login_attempts?
                if user.valid_password?(login_params[:password])
                    session[:user_id] = user.id
                    redirect_to '/dashboard'
                    user.reset_login_attempts
                else
                    user.incorrect_login_attempt
                    helpers.incorrect_credentials
                    redirect_to '/'
                end
            else
                helpers.too_many_logging_attempts
                redirect_to '/'
            end
        else
            helpers.incorrect_credentials
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
