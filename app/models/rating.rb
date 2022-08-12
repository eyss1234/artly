class Rating < ApplicationRecord
  belongs_to :booking
  validates :title, presence: true
  validates :review, presence: true
  validates :rating, presence: true
end
