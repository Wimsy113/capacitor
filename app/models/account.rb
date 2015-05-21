class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable

  has_many :capacities
  has_many :projects, through: :capacities
  has_many :owned_projects, class_name: "Project", foreign_key: :client_id

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  def available_projects
    Project.all
  end
end
