class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :set_booking, only: %i[edit update destroy]

  def new
    @booking = Booking.new()
    authorize @booking
  end

  def create
      @booking = Booking.new(booking_params)
      @booking.user = current_user

      valid = @booking.art_piece.valid_booking?(@booking.start_date, @booking.end_date)
      available = @booking.art_piece.available_for_rent
      authorize @booking

      if valid && available && @booking.save
        redirect_to user_path(current_user), alert: 'Booking made - enjoy your new artwork!'
      elsif valid_booking && available
        render :new, status: :unprocessable_entity
      elsif !available
        flash[:notice] = 'this art piece is not available to rent'
        redirect_to art_piece_path(@booking.art_piece)
      elsif !valid
        flash[:notice] = 'booking overlaps with existing bookings. filter for availability on gallery page'
        redirect_to art_piece_path(@booking.art_piece)
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
