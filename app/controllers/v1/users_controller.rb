class V1::UsersController < ApplicationController

  helper_method :user


  def create
    unless user.save
      render json: { errors: user.errors.messages },
             status: :unprocessable_entity
    end
  end


  private


  def user
    @_user ||= User.new(user_params)
  end


  def user_params
    params.
      require(:user).
      permit(:email, :password, :password_confirmation)
  end

end