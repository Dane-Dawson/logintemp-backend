class User < ApplicationRecord
    # This line is required for bcrypt
    has_secure_password
    validates :username, :email, uniqueness: { case_sensitive: false }
end
