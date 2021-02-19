class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # вписал из видео урока в созданом оригинале нет

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
