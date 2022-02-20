module SessionHelper
  def sign_in(user)
    # cookies.signed[:user_id] = { value: user.id, expires: 10.days, http_only: true }
    session[:current_user_id] = user.id
    self.current_user = user
  end

  def signed_in?
    !session[:current_user_id].nil?
  end

  def sign_out
    # cookies.signed[:user_id] = nil
    session[:current_user_id] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
    # cookies.signed[:user_id])
  end
end
