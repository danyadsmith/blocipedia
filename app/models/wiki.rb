class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :articles, dependent: :destroy
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 3 }, presence: true
  validates :description, length: { maximum: 256 }, presence: true

  def collaborators
    Collaborator.where(wiki_id: id)
  end

  def collaborator
    Collaborator.where(user_id: id)
  end

  scope :visible_to, -> (user) { 
    if user.admin?
      all_viewable
    else
      privately_viewable(user)
    end
  }

  scope :all_viewable, -> { Wiki.order('title ASC').all }
  scope :publicly_viewable, -> { Wiki.where(private: false).order('title ASC') }
  scope :privately_viewable, -> (user) { Wiki.where(["private = ? or user_id = ?", false, user.id]).order('private DESC, title ASC')}
  scope :personally_viewable, -> (user) { Wiki.find_by_sql("SELECT * FROM WIKIS WHERE USER_ID = #{user.id} OR PRIVATE = FALSE OR ID IN (SELECT WIKI_ID FROM COLLABORATORS WHERE USER_ID = #{user.id})")}
  scope :owned_by, -> (user) { Wiki.where(user_id: user.id).order('title ASC')}
  scope :all_private, -> {Wiki.where(private: true).order('title ASC')}

end
