require 'rails_helper'

RSpec.describe HumusBalanceCalculator do
  describe '#call' do
    subject(:call) { described_class.new(crops_values).call }

    context 'when there are no consecutive years' do
      let(:crops_values) { [1, 2, 3, 4, 5] }
      let(:humus_deltas) do
        CropsService.instance.fetch_crops_by_values(crops_values).map { _1[:humus_delta] }
      end

      it 'adds up all the humus_deltas of the field\'s crops' do
        expect(call).to eq(humus_deltas.sum)
        expect(call).to eq(3)
      end
    end

    context 'when there are consecutive years' do
      def delta_by_value(crop_value)
        CropsService::CROPS_BY_VALUE[crop_value][:humus_delta]
      end

      let(:multiplier) { 1.3 }
      let(:crops_values) { [1, 1, 1, 2, 3, 3, 4] }
      let(:humus_deltas) do
        [
          delta_by_value(1),
          delta_by_value(1) * multiplier,
          delta_by_value(1) * multiplier * multiplier,
          delta_by_value(2),
          delta_by_value(3),
          delta_by_value(3) * multiplier,
          delta_by_value(4),
        ]
      end

      it 'adds up all the humus_deltas multiplying consecutive years by 1.3' do
        expect(call).to be_within(1.0e-15).of(humus_deltas.sum)
      end
    end

    context 'when there are no crops provided' do
      let(:crops_values) { [] }

      it 'returns zero' do
        expect(call).to eq(0)
      end
    end
  end
end
