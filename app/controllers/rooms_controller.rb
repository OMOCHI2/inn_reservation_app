class RoomsController < ApplicationController
  before_action :set_user

  def index
    @rooms = Room.where("address like ? and name like ?", "%#{params[:area]}%", "%#{params[:keyword]}%")
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
  end

  def edit
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "編集が正常に完了しました"
      redirect_to own_room_path(@user)
    else
      render edit_room_path(@room)
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
    def set_user
      @user = User.find(current_user.id)
    end

    def room_params
      params.require(:room).permit(:name, :user_id, :introduction, :price, :address, :avatar)
    end
end
