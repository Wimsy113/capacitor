module ProjectHelper
  extend CapacityConverter
  AMOUNT_OPTIONS = [1, 2, 4, 6, 8].map { |i| [to_days(i), i] }

  WORST = 1
  BAD = 2
  OKAY = 3
  GOOD = 4
  BEST = 5
  QUALITY_OPTIONS = [WORST, BAD, OKAY, GOOD, BEST]

  def options_for_project_amount
    options_for_select(AMOUNT_OPTIONS)
  end
end
