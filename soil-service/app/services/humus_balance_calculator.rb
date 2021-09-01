class HumusBalanceCalculator
  CONSECUTIVE_YEAR_MULTIPLIER = 1.3

  def initialize(crops_values)
    @crops_values = crops_values || []
  end

  def call
    balance
  end

  private

  def balance
    crops = CropsService.instance.fetch_crops_by_values(@crops_values)

    result = 0
    previous_humus_delta = nil

    crops.each_with_index do |crop, index|
      consecutive_year = index.positive? && crop[:value] == crops[index - 1][:value]
      delta =
        if consecutive_year
          previous_humus_delta * CONSECUTIVE_YEAR_MULTIPLIER
        else
          crop[:humus_delta]
        end
      previous_humus_delta = delta

      result += delta
    end

    result
  end
end
