class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to edit_profile_path, success: "プロフィールを更新しました。"
    else
      flash.now[:danger] = "プロフィールを更新できませんでした。"
      render :edit
    end
  end

  def followings
  end

  def followers
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cash)
  end
end
