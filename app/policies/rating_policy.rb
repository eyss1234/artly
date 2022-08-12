class RatingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    @user = record.user || user.admin
  end

  def update?
    @user = record.user || user.admin
  end

  def destroy?
    @user = record.user || user.admin
  end

end
