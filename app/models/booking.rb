class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :art_piece
  # validates_presence_of :start_date
  
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validates :start_date, presence: true
end
