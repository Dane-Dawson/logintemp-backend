class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create, :auto_login]
    # ^ We are not requiring the Authorization header for the create method so a user can
    # create an account without being logged in. If you forget this you WILL RUN INTO ISSUES
    # Create in this context could also be called "log_in", but I am calling it "create"
    #  as it is creating a JWT token
  def create
    # Find the user by the params sent in through the login fetch params 
    @user = User.find_by(username: user_login_params[:username])
   
    # User authenticate is a built in method that comes from BCrypt.
    # This next line checks if the user exists, and also if the password given allows access
    if @user && @user.authenticate(user_login_params[:password])
      # encode_token method comes from ApplicationController (which we are inheriting from on line 1).
      #this creates a variable with the value of our token 
      @token = encode_token({ user_id: @user.id })
     
      # UserSerializer is a serializer in the serializers folder. To use this the active_model_serializers gem is needed.
      # This helps clean the data that is sent out to limited attributes you want listed
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :accepted
      
      # Without a serializer or status the following line would suffice
      #  render json: { user: @user, jwt: @token}
      
    else
      # Vague error message for user security (never tell someone they got a specific input incorrect), adding a status code 
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

    # Created this method to allow logging in automatically 
  def auto_login
    @token = params[:token]
    # byebug
    user = User.find(JWT.decode(@token, "put your secret password here", true, algorithm: 'HS256')[0]["user_id"])
    render json: user
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end