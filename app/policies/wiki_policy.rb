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
    return true if user.present? && Wiki.publicly_viewable
    user.present? && Wiki.privately_viewable(user)
    user.present? && user.admin?  
  end

  def destroy?
    return true if user.present? && user.admin?
    user.present? && user.premium? && record.private && user.id == record.user_id
  end



end