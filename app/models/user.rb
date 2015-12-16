class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis 
  has_many :wikis, through: :collaborators, dependent: :destroy

  enum role: [:standard, :premium, :admin]

  def collaborations
    Collaborator.where(user_id: id).pluck(:wiki_id)
  end
  
end
