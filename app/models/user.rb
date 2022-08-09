class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :art_pieces, dependent: :destroy

  validates_presence_of :email, :address

  def existing_bookings
    bookings.filter { |booking| booking.end_date >= Date.today }
            .sort { |a, b| a.start_date <=> b.start_date }
  end

  def past_bookings
    bookings.filter { |booking| booking.end_date < Date.today }
            .sort { |a, b| a.start_date <=> b.start_date }
  end

end
