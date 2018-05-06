class API::V1::AuthController < ApplicationController
  def create
    byebug
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        id: user.id,
        email: user.email,
        jwt: JWT.encode({user_id: user.id}, ENV['secret_key'], 'HS256')
      }
    else
      render json: {error: 'User not found'}, status: 404
    end
  end

  def show
    if current_user
      render json: {
        id: current_user.id,
        email: current_user.email
      }
    else
      render json: {error: 'No id present on headers'}, status: 404
    end
  end
end
