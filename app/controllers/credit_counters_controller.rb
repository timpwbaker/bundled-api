class CreditCountersController < ApplicationController
  def create
    total_remaining_credits = CreditCounter.count(
      user: current_user,
      customer_reference: customer_reference,
      product: product)
    response = { remaining_credits: total_remaining_credits }
    json_response(response, :created)
  end

  private

  def customer_reference
    credit_counter_params[:customer_reference]
  end

  def product
    credit_counter_params[:product]
  end

  def credit_counter_params
    params.permit(:customer_reference, :product)
  end
end
