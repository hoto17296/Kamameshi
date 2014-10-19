class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin
    authenticate_user!
    unless current_user.admin?
      redirect_to :root, status: :forbidden, alert: '権限がありません'
    end
  end
end
