class ArtPiecePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  # Uncomment when the actions in controller are created
  # If the user is owner of the art_piece, it authorizes the update or to destroy, else sets to false  
  
  # def update?
  #   user == record.user 
  #   add user admin when created ->    || user.admin                                     
  # end

  # def destroy?
 #   user == record.user 
#   add user admin when created ->    || user.admin     
  # end
end
