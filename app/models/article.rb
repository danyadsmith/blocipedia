class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :wiki

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, presence: true

end
