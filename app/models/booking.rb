class Booking < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :art_piece

  validates_presence_of :start_date

  validates :end_date, presence: true, date: { after_or_equal_to:  :start_date}
end
