class Log < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  after_save do
    project.calculate_capacity_logged
  end

  scope :recent, lambda {
    start_at = Time.zone.now.beginning_of_week
    end_at = Time.zone.now.end_of_week
    order(worked_at: :desc).where(worked_at: start_at..end_at)
  }

  scope :billable, lambda {
    where(do_not_bill: false)
  }
end
