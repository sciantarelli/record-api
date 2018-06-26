class V1::UsersController < ApplicationController

  helper_method :user

  # TODO: This and other controller(s) methods will need some response handling for error conditions, etc

  def create
    unless user.save
      head(:unprocessable_entity)
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