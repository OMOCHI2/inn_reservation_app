class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :confirm, :create, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :confirm, :create, :edit, :update, :destroy]

  def index
    @reservations = @user.reservations
  end

  def confirm
    if request.post?
      @reservation =  Reservation.new
      @reservation.assign_attributes(reservation_params)
      if @reservation.invalid?
        @room = Room.find(@reservation.room_id)
        render "rooms/show"
      end
    elsif request.patch?
      @reservation = Reservation.find(params[:id])
      @reservation.assign_attributes(reservation_params)
      if @reservation.invalid?
        render "edit"
      end
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
    def reservation_params
      params.require(:reservation).permit(:user_id, :room_id, :start_date, :end_date, :num_of_people)
    end
end
