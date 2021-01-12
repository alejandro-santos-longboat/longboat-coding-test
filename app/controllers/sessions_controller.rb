class SessionsController < ApplicationController
    
    def create
        # Validate request is of post type
        return if !request.post?
       
        # Try get user object by given username in login params
        user = User.get_user(login_params[:username])
        # if no user, username is not valid
        if !user.nil?
            # If valid number of login attempts
            if user.valid_login_attempts?
                # If password is valid, set session to current user and redirect to dashboard
                if user.valid_password?(login_params[:password])
                    session[:user_id] = user.id
                    redirect_to '/dashboard'
                    user.reset_login_attempts
                # Else: Increment login attempts
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
        # Validate request is of post type
        return if !request.post?

        # Invalidate current session
        flash[:login_notice] = "Logged out successfully"
        session[:user_id] = nil
        redirect_to '/'
    end

    private
        # Get login params { username, password }
        def login_params
            params.require(:login).permit(:username, :password)
        end

end
