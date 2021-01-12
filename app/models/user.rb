class User < ApplicationRecord
    # attribute :loging_failure_count, :integer, default: 0
    
    validates :username,    :presence => true, 
                            :length => { :within => 3..20 },
                            format: { with: /\A[a-zA-Z0-9]+\Z/ }

    validates :password,    :presence => true
    validates :salt,        :presence => true

    after_initialize :after_init_callback, :validate_username
    before_save :validate_username

    def self.authenticate(username, password)
        user = User.find_by(username: username.downcase)
        
        return nil if user.nil?

        return user if user.validate_password(password)
    end

    def self.validate_login_attempts(user)
        return false if user.loging_failure_count > 2
        return true
    end

    def validate_password(pass)
        return self.password == Digest::SHA2.hexdigest(self.salt + pass)
    end

    private
        def after_init_callback
            # Initialize logging failure count
            self.loging_failure_count = 0 if self.new_record?

            # Encryp password before saving for the first time
            encrypt_password(self.password) if self.new_record?
        end
        
        def validate_username
            # Save username as lowecase
            self.username = self.username.downcase
        end

        def encrypt_password(pass)
            self.salt = SecureRandom.base64(8)
            self.password = Digest::SHA2.hexdigest(self.salt + pass)
        end
end
