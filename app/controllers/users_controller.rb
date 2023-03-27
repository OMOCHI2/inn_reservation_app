class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :profile, :edit, :update]
  before_action :ensure_correct_user, only: [:show, :profile, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集が正常に完了しました"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar)
    end

    def ensure_correct_user
      if current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to root_path
      end
    end
end
