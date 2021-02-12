class User < ApplicationRecord
    # This line is required for bcrypt
    has_secure_password

    # Validating both email and username for uniqueness, disregarding case_sensitivity
    validates :username, :email, uniqueness: { case_sensitive: false }
end
