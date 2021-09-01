class HumusController < ActionController::Base
  def balance
    balance = HumusBalanceCalculator.new(params[:crops_values]).call
    render json: { balance: balance }
  end
end
