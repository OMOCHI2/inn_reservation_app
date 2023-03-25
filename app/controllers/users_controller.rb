class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :profile, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "無効な操作です"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
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
end
