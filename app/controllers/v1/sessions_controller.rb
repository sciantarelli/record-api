class V1::SessionsController < ApplicationController

  before_action :authenticate_request!, only: [:destroy]
  helper_method :user


  def create
    # TODO: change this to validate as normal once other attributes are added to User
    unless user && user.valid_password?(params[:password])
      # TODO: consider error handling here at some point
      head(:unauthorized)
    end
  end


  def destroy
    # TODO: This seems to work now, but for many hours I was having an issue where calling save on the current user was throwing an empty runtime error. This was even happening when creating a new user, and not using current_user. Somehow, one magical server restart "fixed" it, after having restarted the server numerous times before that.

    current_user.authentication_token = nil

    if current_user.save
      head(:ok)
    else
      # TODO: I don't think this makes sense, return errors instead?
      head(:unauthorized)
    end

  end


  private


  def user
    @_user ||= User.find_by(email: params[:email])
  end


end