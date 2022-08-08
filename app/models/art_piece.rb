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

  def valid_booking?(d_start, d_end)
    b = bookings.filter do |booking|
      straddles_start_date = booking.end_date > d_start && booking.start_date <= d_start
      straddles_end_date = booking.start_date < d_end && booking.end_date > d_end
      straddles_start_date || straddles_end_date
    end
    b.empty?
  end
end
