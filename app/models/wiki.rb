class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :articles, dependent: :destroy

  validates :title, length: { minimum: 3 }, presence: true
  validates :description, length: { maximum: 256 }, presence: true

  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :publicly_viewable, -> { Topic.where(private: false) }
  scope :privately_viewable, -> { Topic.where(private: true) }  
end
