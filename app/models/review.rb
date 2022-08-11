class Review < ApplicationRecord
  belongs_to :booking
  belong_to :user, through: :booking
  belongs_to :art_piece, through: :booking

  validates :title, presence: true
  validates :details, presence: true
end
