module SessionsHelper
    def flash_login_message(message)
        flash[:login_notice] = message
    end

    def incorrect_credentials
        flash_login_message('Invalid credentials; user does not exist or password is incorrect')
    end

    def too_many_logging_attempts
        flash_login_message('Too many failed logging attempts, please contact a site administrator to unlock this account.')
    end
end
