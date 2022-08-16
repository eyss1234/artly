class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :art_piece

  has_one :rating

  validates :start_date, presence: true
  validates :end_date, presence: true
end
