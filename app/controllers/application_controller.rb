class ApplicationController < ActionController::API
  include ActionController::Helpers

  acts_as_token_authentication_handler_for User, fallback: :none

  rescue_from UnauthorizedRequestError,
              with: :unauthorized_action


  def authenticate_request!
    unless current_user
      raise UnauthorizedRequestError
    end
  end


  def unauthorized_action
    render json: { error: 'Not Authorized' },
           status: :unauthorized
  end
end