# Here we simulate a database connection with Fields
class FieldsService
  include Singleton

  def fetch_fields
    result = [
      {
        id: 1,
        name: 'Mäeotsa',
        area: 0.93,
        crops: [
          { year: 2020, crop: CropsService::WINTER_WHEAT },
          { year: 2021, crop: CropsService::OATS },
          { year: 2022, crop: CropsService::WINTER_WHEAT },
          { year: 2023, crop: CropsService::OATS },
          { year: 2024, crop: CropsService::WINTER_WHEAT },
        ],
      },
      {
        id: 2,
        name: 'Tiigimanu',
        area: 3.14,
        crops: [
          { year: 2020, crop: CropsService::SPRING_WHEAT },
          { year: 2021, crop: CropsService::OATS },
          { year: 2022, crop: CropsService::RED_CLOVER },
          { year: 2023, crop: CropsService::WINTER_WHEAT },
          { year: 2024, crop: CropsService::BROAD_BEAN },
        ],
      },
      {
        id: 3,
        name: 'Künkatagune',
        area: 5.18,
        crops: [
          { year: 2020, crop: CropsService::SPRING_WHEAT },
          { year: 2021, crop: CropsService::SPRING_WHEAT },
          { year: 2022, crop: CropsService::SPRING_WHEAT },
          { year: 2023, crop: CropsService::SPRING_WHEAT },
          { year: 2024, crop: CropsService::SPRING_WHEAT },
        ],
      },
    ]

    result.each do |field|
      crops_values = field[:crops].map { _1[:crop][:value] }
      field[:humus_balance] = HumusBalanceCalculator.new(crops_values).call
    end

    result
  end
end
