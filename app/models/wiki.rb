class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 3 }, presence: true
  validates :description, length: { maximum: 256 }, presence: true
  validates :private, presence: true
end
