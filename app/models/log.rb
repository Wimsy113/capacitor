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
    order(worked_at: :desc).where(worked_at: start_at..Date.today)
  end

  scope :filter, ->(conditions) do
    where_clauses = []
    where_clauses.push(["worked_at >= ?", conditions[:after_date]]) if conditions[:after_date]
    where_clauses.push(["worked_at <= ?", conditions[:before_date]]) if conditions[:before_date]
    where_clauses.push(do_not_bill: false) if conditions[:billable]
    where_clauses.push(project_id: conditions[:projects]) if conditions[:projects]
    where_clauses.reduce(self) { |search_query, clause|
      if clause.respond_to?(:keys)
        search_query.where(clause)
      else
        field, condition = clause
        search_query.where(field, condition)
      end
    }
  end
end
