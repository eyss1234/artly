class ArtPiecesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show update destroy]
  before_action :set_art_piece, only: %i[ show edit update destroy ]

  def index
    @art_pieces = policy_scope(ArtPiece)
    @art_pieces = @art_pieces.filter { |art| art.available_for_rent }
    filter_by(params)
    sort_by(params)
    @sort_options = ["None", "Top Rated", "Price ascending", "Price descending"]
    @sort_options.delete(params[:sort])
  end

  def new
    @art_piece = ArtPiece.new()
    authorize @art_piece
  end

  def show
    lon, lat = mapbox_coordinates
    @map_image_url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s+545454(#{lon},#{lat})/#{lon},#{lat},12.05,0/1000x300?access_token=#{ENV['MAPBOX_API']}"
    @booking = Booking.new()
    @booking.art_piece = @art_piece
    @url = user_signed_in? ? art_piece_bookings_path(@art_piece) : new_user_session_path
    @verb = user_signed_in? ? :post : :get
  end

  def create
    @art_piece = ArtPiece.new(art_piece_params)
    @art_piece.user = current_user
    authorize @art_piece

    if @art_piece.save
      @art_piece.update(art_piece_photos)
      redirect_to art_piece_path(@art_piece), alert: 'Art piece submitted sucessfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @art_piece.update(art_piece_edit_params)
      if params[:art_piece][:photos].count > 1
        @art_piece.update(art_piece_photos)
      end
      redirect_to art_piece_path(@art_piece)
    else
      render :edit
    end
  end

  def destroy
    if @art_piece.live_bookings.empty?
      @art_piece.destroy
      redirect_to art_pieces_path, method: :get, notice: 'Art piece was successfully destroyed.'
    else
      redirect_to art_piece_path(@art_piece), notice: "Can't delete art with active bookings."
    end
  end

  private

  def art_piece_params
    params.require(:art_piece).permit(:name, :genre, :description, :cost_per_day, :available_for_rent, photos: [])
  end

  def art_piece_edit_params
    params.require(:art_piece).permit(:name, :genre, :description, :cost_per_day, :available_for_rent)
  end

  def art_piece_photos
    params.require(:art_piece).permit(photos: [])
  end

  def set_art_piece
    @art_piece = ArtPiece.find_by_id(params[:id])
    if @art_piece
      authorize @art_piece
    else
      redirect_to art_pieces_path
    end
  end

  def mapbox_coordinates
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@art_piece.user.address}.json"
    res = JSON.parse(HTTP.get(url, params: {access_token: ENV['MAPBOX_API']}).body)
    res["features"].first["geometry"]["coordinates"]
  end

  def filter_by(params)

    if params[:genres]
      @art_pieces = @art_pieces.filter do |art_piece|
        params[:genres].include?(art_piece.genre)
      end
    end

    if params[:start_date] || params[:end_date]
      unless (params[:start_date].empty? && params[:end_date].empty?)
        params[:start_date] = params[:end_date] if params[:start_date].empty?
        params[:end_date] = params[:start_date] if params[:end_date].empty?

        if params[:start_date] || params[:end_date]
          @art_pieces = @art_pieces.filter do |art_piece|
            art_piece.valid_booking?(
              params[:start_date] || params[:end_date],
              params[:end_date] || params[:start_date]
            )
          end
        end
      end
    end
  end

  def sort_by(params)

    params[:sort] = params[:commit] unless (params[:commit]||'').include?('Apply')

    # add top rated sort by average if possible
    if params[:sort] === "Price ascending"
      @art_pieces = @art_pieces.sort_by { |a| a.cost_per_day }
    elsif params[:sort] === "Price descending"
      @art_pieces = @art_pieces.sort_by { |a| -a.cost_per_day }
    end

  end
end
