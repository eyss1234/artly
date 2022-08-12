class RatingsController < ApplicationController
  before_action :set_rating, only: %i[edit update destroy]

  def new
    @rating = Rating.new()
    authorize @rating
  end

  def create
    @rating = Rating.create(rating_params)
  end

  def edit
  end

  def update
    @rating.update(rating_params)
    redirect_to user_path(current_user)
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
