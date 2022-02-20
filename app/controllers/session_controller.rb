# frozen_string_literal: true

class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]

  def login; end

  def create
    user = User.find_by(username: params[:username])
    p user&.username

    if user&.authenticate(params[:password])
      p 'success'
      sign_in user
      redirect_to root_path
    else
      flash[:error] = t('forms.messages.invalid_credentials')
      redirect_to login_path
    end
  end

  def logout
    sign_out
    redirect_to login_path
  end
end
