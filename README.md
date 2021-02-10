# README

This is a template to help you with AN approach (not the only or the best) for setting up JWT authentication, and is paired with the following front-end template:

https://github.com/Dane-Dawson/logintemp-frontend

I HIGHLY ENCOURAGE not to clone this repo or directly copy and paste from it, but to write all your code yourself (even if you use this template as a direct starting point). Sometimes there are some hidden character issues with copy pasting from the github pages that will give you very confusing errors.

For examples of how THIS repo does the following steps visit the related files in this repo for (maybe) more comments and (definitely) an example

Gemfile
-add/uncomment bcrypt
-add/uncomment jwt
bundle install/update

User model needs (at least) the following:
-Schema must have name/email/some unique attribute to locate user in DB during login
-Schema must have at least password_digest attribute for bcrypt authentication
-Recommended to have a password_confirmation (this one doesn't)
-User.rb file needs has_secure_password
-User.rb file needs a validated attribute for uniqueness to use for login
-Remember that when doing User.create you pass it a :password attribute that bcrypt will translate into a password_digest for storage.

Routes
-post "login" path to auth_controller "create" method
-delete "logout" path to auth_controller "destroy" method
-get "logged_in?" path to application_controller "logged_in?" method

