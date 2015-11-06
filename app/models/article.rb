class Article < ActiveRecord::Base
  belongs_to :wiki

    validates :title, length: { minimum: 3 }, presence: true
    validates :body, presence: true
end
