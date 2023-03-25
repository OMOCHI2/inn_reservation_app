class ReservationsController < ApplicationController
  before_action :set_user

  def index
    @reservations = @user.reservations
  end

  def confirm
    @reservation = Reservation.find_or_initialize_by(id: params[:id])
    @reservation.assign_attributes(reservation_params)
    if @reservation.invalid?
      @room = Room.find(@reservation.room_id)
      render "rooms/show"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
    flash[:notice] = "予約が完了しました"
    redirect_to reservations_path
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    flash[:notice] = "予約変更が正常に完了しました"
    redirect_to reservations_path
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to reservations_path
  end

  private
    def set_user
      @user = User.find(current_user.id)
    end

    def reservation_params
      params.require(:reservation).permit(:user_id, :room_id, :start_date, :end_date, :num_of_people)
    end
end
