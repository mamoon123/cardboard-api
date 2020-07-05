class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register forgot_password]
  before_action :set_user, only: [:update_password]

  # POST /register
  def_param_group :register do
    param :email, String, desc: "Email", required: true
    param :password, String, desc: "Password", required: true
    param :name, String, desc: "Full Name", required: true
  end

  def_param_group :login do
    param :email, String, desc: "Email", required: true
    param :password, String, desc: "Password", required: true
  end


  api :POST, '/v1/register', "Returns access_token for api access"
  param_group :register
  #error 401, "If email/password is incorrect."
  error 400, "If email already present."
  description 'Get access_token for api access'
  def register
    @user = User.new(user_params)
    if @user.save
      authenticate(user_params[:email], user_params[:password], 'User created successfully')
    else
      #render json: @user.errors, status: :bad
      #      render json: { message: user_params[:email]+" "+@user.errors.messages[:email][0] }, status: :unauthorized
      respond_to do |format|
        format.json { render json: { message:user_params[:email]+" "+@user.errors.messages[:email][0], status: :unauthorized } , status: :unauthorized }
      end
    end
  end


  api :POST, '/v1/login', "Returns access_token for api access"
  param_group :login
  error 401, "If email/password is incorrect."
  error 400, "If email/password is not present."
  description 'Get access_token for api access'
  def login
    authenticate params[:email], params[:password], 'Login Successful'
  end

  private
  def secure_password
    SecureRandom.hex(10)
  end

  def user_params
    params.permit(:name, :email, :password)
  end

  def authenticate(email, password, message)
    command = AuthenticateUser.call(email, password)
    #puts command.errors[:user_authentication][0]

    if command.success?
      render json: {
          access_token: command.result.first,
          message: message,
          user: command.result.second,
      }
    else
      #render json: { error: command.errors }, status: :unauthorized
      respond_to do |format|
        format.json { render json: { message: command.errors[:user_authentication][0], status: :unauthorized } , status: :unauthorized }
      end
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
