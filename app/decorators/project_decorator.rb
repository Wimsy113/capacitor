require "capacity_converter"

class ProjectDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def capacity_remaining
    if project.capacity == -1
      "Infinity"
    else
      project.capacity_remaining.to_business_days
    end
  end

  def weekly_burn_rate
    project.weekly_burn_rate ? project.weekly_burn_rate.to_business_days : "No days"
  end

  def weekly_capacity_remaining
    if project.weekly_capacity_remaining > 0
      project.weekly_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end
end
