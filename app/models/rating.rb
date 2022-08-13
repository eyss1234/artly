class Rating < ApplicationRecord
  belongs_to :booking
  belongs_to :art_piece, :through => :booking
  belongs_to :user, :through => :booking


  validates :title, presence: true
  validates :review, presence: true
  validates :rating, presence: true

  validates :title, presence: true, length: { minimum: 3 }
  validates :review, presence: true, length: { minimum: 10 }
  validates :rating, { in: 1..5 }

end
