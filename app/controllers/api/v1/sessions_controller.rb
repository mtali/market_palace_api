class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.valid_password?(session_params[:password])
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

end
