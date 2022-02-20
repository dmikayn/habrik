# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user
  around_action :select_locale

  include SessionHelper

  before_action :require_login

  private

  def require_login
    redirect_to login_url unless signed_in?
  end

  def refuse_with_method_not_allowed
    respond_to do |format|
      format.all { render html: 'Method not allowed', status: :method_not_allowed }
    end
  end

  def set_current_user
    @current_user = current_user
  end

  def retrieve_locales
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/[a-z]{2}/)
  end

  def valid_locale
    retrieve_locales&.find { |locale| I18n.available_locales.include? locale.intern } || I18n.default_locale
  end

  def select_locale(&action)
    I18n.with_locale(valid_locale, &action)
  end
end
