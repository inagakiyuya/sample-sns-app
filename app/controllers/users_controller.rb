class UsersController < ApplicationController
  # 新規ユーザーを作成して登録するためのコントローラー
  skip_before_action :require_login, only: %i[new create]
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: "新規ユーザー登録に成功しました。"
    else
      flash.now[:danger] = "新規ユーザー登録に失敗しました。"
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
