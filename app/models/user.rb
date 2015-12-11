class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis

  enum role: [:standard, :premium, :admin]

  def collaborations
    Collaborator.where(user_id: id).pluck(:wiki_id)
  end
  
end
