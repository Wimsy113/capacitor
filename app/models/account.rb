class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable

  has_many :logs
  has_many :projects, through: :capacities
  has_many :owned_projects, class_name: "Project", foreign_key: :client_id

  validates :name, presence: true

  def available_projects
    Project.all
  end

  def total_recent_capacity
    logs.recent.pluck(:amount).sum
  end

  def remaining_personal_capacity
    weekly_expected_capacity - total_recent_capacity
  end
end
