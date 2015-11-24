class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :articles, dependent: :destroy

  validates :title, length: { minimum: 3 }, presence: true
  validates :description, length: { maximum: 256 }, presence: true

  scope :visible_to, -> (user) { 
    if user.admin?
      all_viewable
    elsif user.premium?
      privately_viewable(user)
    else
      publicly_viewable
    end
  }

  scope :all_viewable, -> { Wiki.order('title ASC').all }
  scope :publicly_viewable, -> { Wiki.where(private: false).order('title ASC') }
  scope :privately_viewable, -> (user) { Wiki.where(["private = ? or user_id = ?", false, user.id]).order('private DESC, title ASC')}
  scope :owned_by, -> (user) { Wiki.where(user_id: user.id).order('title ASC')}
  scope :all_private, -> {Wiki.where(private: true).order('title ASC')}

end
