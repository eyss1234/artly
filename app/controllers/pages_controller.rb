class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @art_pieces = ArtPiece.all.sample(3)
    # authorize @art_pieces
  end
end
