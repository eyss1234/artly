class ArtPiece < ApplicationRecord
  belongs_to :user, dependent: :destroy

  GENRES = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

  validates_presence_of :name, :genre

  validates :genre, inclusion: { in: GENRES }
end
