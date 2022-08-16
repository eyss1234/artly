class RatingsController < ApplicationController
  before_action :set_rating, only: %i[edit update destroy]

  def new
    @rating = Rating.new()
    @booking = Booking.find(params[:booking_id])
    authorize @booking
    authorize @rating
    @method = :post
    @url = booking_ratings_path(@booking)
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.booking_id = params[:booking_id]
    authorize @rating
    if @rating.save
      redirect_to art_piece_path(@rating.booking.art_piece)
    else
      render new_booking_rating_path(@rating.booking), status: :unprocessable_entity
    end
  end

  def edit
    @method = :patch
    @url = rating_path(@rating)
  end

  def update
    @rating.update(rating_params)
    redirect_to art_piece_path(@rating.booking.art_piece)
  end

  def destroy
    @rating.destroy
    redirect_to user_path(current_user)
  end

  private

  def rating_params
    params.require(:rating).permit(:title, :review, :rating)
  end

  def set_rating
    @rating = Rating.find(params[:id])
    authorize @rating
  end
end
