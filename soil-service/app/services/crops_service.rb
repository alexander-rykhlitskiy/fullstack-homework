# Here we simulate a database connection with Crops
class CropsService
  include Singleton

  SPRING_WHEAT = { value: 1, label: 'Spring Wheat', humus_delta: -2 }.freeze
  WINTER_WHEAT = { value: 2, label: 'Winter Wheat', humus_delta: -1 }.freeze
  RED_CLOVER = { value: 3, label: 'Red Clover', humus_delta: 2 }.freeze
  WHITE_CLOVER = { value: 4, label: 'White Clover', humus_delta: 1 }.freeze
  BROAD_BEAN = { value: 5, label: 'Broad Bean', humus_delta: 3 }.freeze
  OATS = { value: 6, label: 'Oats', humus_delta: 0 }.freeze

  CROPS = [
    SPRING_WHEAT,
    WINTER_WHEAT,
    RED_CLOVER,
    WHITE_CLOVER,
    BROAD_BEAN,
    OATS,
  ].freeze

  CROPS_BY_VALUE = CROPS.index_by { _1[:value] }.freeze

  def fetch_all_crops
    CROPS
  end

  def fetch_crops_by_values(values)
    values.map { |value| CROPS_BY_VALUE[value.to_i] }
  end
end
