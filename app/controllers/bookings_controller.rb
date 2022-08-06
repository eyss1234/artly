class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :set_booking, only: %i[edit update destroy]

  def new
    @booking = Booking.new()
    authorize @booking
  end

  def create
    raise
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to user_path(current_user), alert: 'Booking made - enjoy your new artwork!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to user_path(current_user), notice: 'Booking removed 😔'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :art_piece_id)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

end
