class ArtPiecesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_art_piece, only: %i[ show ]
  # add edit update and destroy to before_action after actions are created

  def index
    @art_pieces = policy_scope(ArtPiece)
  end

  def show
    lon, lat = mapbox_coordinates
    @map_image_url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s+545454(#{lon},#{lat})/#{lon},#{lat},12.05,0/1000x300?access_token=#{ENV['MAPBOX_API']}"
  end

  def new
    @art_piece = ArtPiece.new()
    authorize @art_piece
  end

  def create
    @art_piece = ArtPiece.new(art_piece_params)
    @art_piece.user = current_user
    authorize @art_piece
    if @art_piece.save
      redirect_to art_piece_path(@art_piece), alert: 'Art piece submitted sucessfully'
    else
      render :index, status: :unprocessable_entity
    end
  end



#   def edit
#   end

#   def update
#     if @art_piece.update(art_piece_params)
#       redirect_to art_piece_path(@art_piece)
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @art_piece.destroy
#     redirect_to art_pieces_path, notice: 'Art piece was successfully destroyed.'
#   end

  private

  def art_piece_params
    params.require(:art_piece).permit(:name, :genre, :photos)
  end

  def set_art_piece
    @art_piece = ArtPiece.find(params[:id])
    authorize @art_piece
  end

  def mapbox_coordinates
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@art_piece.user.address}.json"
    res = JSON.parse(HTTP.get(url, params: {access_token: ENV['MAPBOX_API']}).body)
    res["features"].first["geometry"]["coordinates"]
  end

end
