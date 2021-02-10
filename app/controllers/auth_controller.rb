class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
    # ^ We are not requiring the Authorization header for the create method so a user can
    # create an account without being logged in. If you forget this you WILL RUN INTO ISSUES
    # Create in this use could also be called "log_in", but it being called "create"
    #  as it is creating a JWT token
  def create
    # Find the user by the params sent in through the login page
    @user = User.find_by(username: user_login_params[:username])
   
    # User authenticate is a built in method that comes from BCrypt.
    # This checks if the user exists, and also if the password given authenticates access
    if @user && @user.authenticate(user_login_params[:password])
      # encode_token method comes from ApplicationController (which we are inheriting from on line 1).
      #this creates our token in it's own unique line and lets us pass it in
      @token = encode_token({ user_id: @user.id })
     
      # UserSerializer is a serializer in the serializers folder. To use this the active_model_serializers gem is needed.
      # This helps clean the data that is sent out to limited attributes you want listed
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :accepted
     
    else
      # Vague error message for user security, adding a status code 
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end