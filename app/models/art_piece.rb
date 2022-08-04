class ArtPiece < ApplicationRecord
  belongs_to :user
  has_many :bookings, :dependent => :restrict_with_error
  has_many_attached :photos

  GENRES = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

  validates_presence_of :name, :genre, :description
  validates :genre, inclusion: { in: GENRES }
end
