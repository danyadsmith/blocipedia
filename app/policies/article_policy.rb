class ArticlePolicy < ApplicationPolicy

  private

  def article
    record
  end

  def authorize_default
    return true if user.present? && article.wiki.private == false
    user.present? && article.wiki.private == true && article.user == user
    user.present? && user.admin?    
  end

end