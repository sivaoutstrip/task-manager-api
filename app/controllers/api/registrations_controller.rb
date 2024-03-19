module Api
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @user = User.new(registrations_params)
      return render json: @user.errors.full_messages, status: :unprocessable_entity unless @user.save

      render :create, status: 201
    end

    private

    def registrations_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
