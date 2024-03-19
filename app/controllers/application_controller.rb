# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    user_id = JsonWebToken.decode(request.headers['Authorization'])
    return unauthorized_msg if user_id.nil?

    @current_user = User.find_by(id: user_id)
    return unauthorized_msg if @current_user.nil?

    @current_user
  end

  private

  def unauthorized_msg
    render json: unauthorized_msg, status: :unauthorized
  end
end
