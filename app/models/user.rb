class User < ApplicationRecord
    attribute :login_failure_count, :integer, default: 0
    
    validates :username,    :presence => true, 
                            :length => { :within => 3..20 },
                            :uniqueness => true,
                            format: { with: /\A[a-zA-Z0-9]+\Z/ }

    validates :password,    :presence => true
    validates :salt,        :presence => true

    after_initialize :validate_password_encryption, :validate_username_case

    def valid_password?(pass)
        return self.password == Digest::SHA2.hexdigest(self.salt + pass)
    end
    
    def valid_login_attempts?
        self.login_failure_count < 3
    end

    def incorrect_login_attempt
        self.login_failure_count = self.login_failure_count + 1     
        self.save
    end
    
    def reset_login_attempts
        self.login_failure_count = 0
    end
    
    def self.get_user(username)
        User.find_by(username:username)
    end

    private
        def validate_password_encryption
            # Encryp password before saving for the first time
            encrypt_password(self.password) if self.new_record? && !self.password.nil? 
        end

        def validate_username_case
            # Save username as lowecase
            self.username = self.username.downcase if !self.username.nil? 
        end

        def encrypt_password(pass)
            self.salt = SecureRandom.base64(8)
            self.password = Digest::SHA2.hexdigest(self.salt + pass)
        end
end
