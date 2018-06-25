class V1::SessionsController < ApplicationController


  def create
    # TODO: Refactor this
    user = User.find_by(email: params[:email])

    # TODO: change this to validate as normal once other attributes are added to User
    if user && user.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end


  def destroy
    # TODO: This seems to work now, but for many hours I was having an issue where calling save on the current user was throwing an empty runtime error. This was even happening when creating a new user, and not using current_user. Somehow, one magical server restart "fixed" it, after having restarted the server numerous times before that.

    unless current_user
      head(:unauthorized)
      return
    end

    current_user.authentication_token = nil

    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end

  end


end