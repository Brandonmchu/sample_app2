module SessionsHelper
  def sign_in(user)
      cookies.permanent[:remember_token] = user.remember_token
      # cookies[:remember_token] = { value: user.remember_token,
      #                              expires: 20.years.from_now }
      current_user = user
  end
  def signed_in?
    !current_user.nil?
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    #means same as x += 1 is x= x+1, @current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])
  end
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

end
