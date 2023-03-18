class UsersController < ApplicationController
  before_action :set_user, only: [:show, :profile, :edit, :update]
  before_action :authenticate_user!, only: [:show, :profile, :edit, :update]

  def show

  end

  def profile

  end

  def edit
    if @user != current_user
      flash[:notice] = "無効な操作です"
      redirect_to root_path
    end
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "編集が正常に完了しました"
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar)
    end
end
