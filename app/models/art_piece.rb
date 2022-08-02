class ArtPiece < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings, :dependent => :restrict_with_error
  has_many_attached :photos
  
  GENRES = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

  validates_presence_of :name, :genre
  validates :genre, inclusion: { in: GENRES }
end
