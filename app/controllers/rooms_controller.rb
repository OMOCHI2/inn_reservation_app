class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :own]
  before_action :login_check, only: [:show]
  before_action :set_user, only: [:new, :create, :show, :edit, :update, :destroy, :own]

  def index
    @rooms = Room.where("address like ? and (name like ? or introduction like ?)", "%#{params[:area]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "新しい宿泊施設を登録しました"
      redirect_to rooms_path
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
    if @user.id == @room.user_id
      @reservation = Reservation.new
    else
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "編集が正常に完了しました"
      redirect_to own_room_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "削除が正常に完了しました"
    redirect_to own_rooms_path
  end

  def own
    @rooms = @user.rooms
  end

  private
    def room_params
      params.require(:room).permit(:name, :user_id, :introduction, :price, :address, :avatar)
    end

    def login_check
      if current_user.nil?
        flash[:notice] = "以降の閲覧にはログインが必要です"
        redirect_to new_user_session_path
      end
    end
end
