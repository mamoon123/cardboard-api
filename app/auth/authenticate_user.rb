# app/auth/authenticate_user.rb
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  #this is where parameters are taken when the command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  #this is where the result gets returned
  def call
    @user = user
    token = JsonWebToken.encode(user_id: @user.id) if @user
    return token, @user
  end

  private

  def user
    user = User.find_by_email(email.downcase)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'Invalid Email or Password.'
    nil
  end
end