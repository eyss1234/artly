class ArtPiece < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  GENRES = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

  validates_presence_of :name, :genre, :description
  validates :genre, inclusion: { in: GENRES }

  def live_bookings
    bookings.filter { |booking| booking.end_date >= Date.today }
            .sort { |a, b| a.start_date <=> b.start_date }
  end
end
