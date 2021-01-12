module DashboardHelper

    def get_user(user_id)
        User.find(user_id)
    end

    def get_username(user_id)
        get_user(user_id).username
    end
    
end
