class UserSessionsController < ApplicationController
  # 登録したユーザーがログインするためのコントローラー
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to posts_path, success: "ログインに成功しました。"
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to login_path, success: "ログアウトに成功しました。"
  end
end
