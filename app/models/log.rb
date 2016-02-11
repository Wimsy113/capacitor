class Log < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  scope :billable, -> do
    where(do_not_bill: false)
  end

  scope :recent, ->(start_at = 7.days.ago) do
    order(worked_at: :desc).where(worked_at: start_at..Time.zone.now.to_date)
  end

  scope :from_weeks_ago, ->(weeks_ago = 0) do
    week = weeks_ago.weeks.ago
    order(worked_at: :desc).where(worked_at: week.beginning_of_week..week.end_of_week)
  end

  scope :two_months_ago, ->(months_ago = 2) do
      where(created_at: 2.months_ago)
  end

  def self.filter(conditions)
    Filter.new(collection: all, conditions: conditions).results
    project.logs.up_to_two_months_ago
  end
end
