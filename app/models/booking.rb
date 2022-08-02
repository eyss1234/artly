class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :art_piece

  validates_presence_of :start_date, :end_date
end
