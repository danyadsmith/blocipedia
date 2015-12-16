class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    return true if user.present? && Wiki.publicly_viewable
    user.present? && Wiki.privately_viewable(user)
    user.present? && user.admin?  
  end

  def create?
    return true if user.present? && Wiki.publicly_viewable
    user.present? && Wiki.privately_viewable(user)
    user.present? && user.admin?  
  end

  def update?
    return true if user.present? && user.admin?  
    user.present? && user.premium? && record.private && user.id == record.user_id
  end

  def destroy?
    return true if user.present? && user.admin?
    user.present? && user.premium? && record.private && user.id == record.user_id
  end  

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.find_by_sql("SELECT * FROM WIKIS WHERE USER_ID = #{user.id} OR PRIVATE = FALSE OR ID IN (SELECT WIKI_ID FROM COLLABORATORS WHERE USER_ID = #{user.id}) ORDER BY PRIVATE DESC, TITLE ASC")
      end
    end
  end
end