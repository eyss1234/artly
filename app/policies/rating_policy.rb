class RatingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    true #@user = record.user || user.admin
  end

  def update?
    true #@user = record.user || user.admin
  end

  def destroy?
    true #@user = record.user || user.admin
  end

end
