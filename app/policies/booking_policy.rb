class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # anyone can make a booking unless its their own art
  def create?
    not_own_art = current_user != record.art_piece.user
    current_user == record.user && not_own_art
  end

  # only booking user can destroy or edit a booking
  def destroy?
    update?
  end

  def update?
    current_user == record.user
  end

end
