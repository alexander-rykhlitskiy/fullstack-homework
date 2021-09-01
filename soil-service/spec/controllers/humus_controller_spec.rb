require 'rails_helper'

RSpec.describe HumusController do
  describe 'GET balance' do
    it 'calculates and returns humus balance for specified crops' do
      get :balance, params: { crops_values: [1, 2, 3] }
      expect(response.status).to eq(200)

      expect(json_response[:balance]).to eq(-1)
    end

    it 'returns humus balance as null when crops are not specified' do
      get :balance
      expect(response.status).to eq(200)

      expect(json_response[:balance]).to eq(0)
    end
  end
end
