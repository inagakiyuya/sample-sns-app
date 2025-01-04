class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_q
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

  def not_authenticated
    redirect_to login_path, warning: "ログインしてください。"
  end
end
