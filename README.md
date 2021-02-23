# README

## Welcome! 

### Take a moment to read through this brief README before you do anything else!
<br/>
This is a template to help you with AN approach (not the only or the best) for setting up JWT authentication, and is paired with the following front-end template:

https://github.com/Dane-Dawson/logintemp-frontend

I HIGHLY ENCOURAGE not to just clone this repo and make your project off this as a base, or directly copy and paste from it. Rather you should write all your code yourself, even if you use this template as a direct inspiration. Besides the fact that writing it yourself helps you learn and understand it, sometimes there are some hidden character issues with copy pasting from the github pages that will give you very confusing errors. I have taken the time to make a copy of the authController and the ApplicationController without comments so you can see the code more cleanly too.

<br/><br/>
For examples of how THIS repo does the following steps visit the related files in this repo for (maybe) more comments and (definitely) an example


Installation guide. YOU MUST RUN THIS SERVER FOR THIS DEMO TO WORK
```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
```
If you run into issues with installing Puma try
```
gem install puma:4.3.3 -- --with-cflags="-Wno-error=implicit-function-declaration"
```

## Let's get to it
![Let's get to it](https://media.tenor.com/images/094986569421b4a0550d545698d48b01/tenor.gif)

Noted below are the files to pay attention to with brief descriptions to what's needed in each one, but do take the time to really understand everything that is going on. There are a lot of moving parts and it can be difficult to tell exactly what is happening. Feel free to use byebug or other tools you are familiar with to track data flow and pick apart what is happening. <br/> 
To clarify, the things listed below have ALREADY been done on *this* repo, but are the things you should focus on for your project to add JWT!</br><br/>
Gemfile
* add/uncomment bcrypt
* add/uncomment jwt

User model needs (at least) the following:
* Schema must have name/email/some unique attribute to locate user in DB during login
* Schema must have at least password_digest attribute for bcrypt authentication
* Recommended to have a password_confirmation (this one doesn't)
* User.rb file needs has_secure_password
* User.rb file needs a validated attribute for uniqueness to use for login
* Remember that when doing User.create in params the password should be sent in as a :password attribute. bcrypt will take care of translating it into a password_digest for us.

Routes
* post "login" path to auth_controller "create" method
* get "logged_in?" path to application_controller "logged_in?" method
* users_controller create method before_action :authentication

"Thing" model (or whatever model/models you are including authenticated routes on)
* specify for which methods authentication is needed at the top of the controller

Auth_controller
* Ability to create a JWT token (with password verification in this template)
* Declaration that you DO NOT need authentication to create a token (before_action :authentication)

Application_controller
* Encoding and decoding of tokens
* authentication method to trigger as a before_action to use as authentication check

