class UserSerializer < ActiveModel::Serializer
  # This is just making it whenever it is used (auth_controller create method)
  #   it only allows the following attributes through
    attributes :username, :email, :id
  end