class AddCostToArtPieces < ActiveRecord::Migration[7.0]
  def change
    add_column :art_pieces, :cost_per_day, :integer
  end
end
