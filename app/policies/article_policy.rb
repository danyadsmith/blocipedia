class ArticlePolicy < ApplicationPolicy

  private

  def article
    record
  end

end