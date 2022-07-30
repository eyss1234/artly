class CreateArtPieces < ActiveRecord::Migration[7.0]
  def change
    create_table :art_pieces do |t|
      t.string :description
      t.string :name
      t.string :genre
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
