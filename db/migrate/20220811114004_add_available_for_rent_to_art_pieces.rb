class AddAvailableForRentToArtPieces < ActiveRecord::Migration[7.0]
  def change
    add_column :art_pieces, :available_for_rent, :boolean, default: true
  end
end
