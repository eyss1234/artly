class ArtPiece < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  GENRES = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

  validates_presence_of :name, :genre, :description
  validates :genre, inclusion: { in: GENRES }

  def live_bookings
    return bookings.filter do |booking|
      booking.end_date >= Date.today
    end
  end
end
