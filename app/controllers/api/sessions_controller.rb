# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @user = User.find_by(email: sessions_params[:email])
      return invalid_crendentials if @user.nil?

      return invalid_crendentials unless @user.authenticate(sessions_params[:password])

      render :create, status: 200
    end

    private

    def invalid_crendentials
      render json: { message: 'Invalid credentials' }, status: :unprocessable_entity
    end

    def sessions_params
      params.permit(:email, :password)
    end
  end
end
