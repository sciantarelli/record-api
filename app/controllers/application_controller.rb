class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Helpers


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