class ArtPiecesController < ApplicationController
  before_action :set_art_piece, only: %i[edit update]

  def new
    @list = Art_piece.new()
  end

  def create
    @art_piece = Art_piece.new(art_piece_params)
    if @art_piece.save
      redirect_to art_piece_path(@art_piece), alert: 'Art piece submitted sucessfully'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    @art_piece.update(art_piece_params)
    redirect_to art_piece_path(@art_piece)
  end

  def destroy
    redirect_to art_pieces_path, status: :see_other
  end

  private

  def art_piece_params
    params.require(:art_piece).permit(:name, :genre,)
  end

  def set_art_piece
    @list = Art_piece.find(params[:id])
  end

end
