class CreditAdjustmentsController < ApplicationController
  def create
    if credit_adjuster.adjust
      response = {credit_adjustment: credit_adjuster.credit_adjustment,
                  remaining_credits: credit_counter}
      json_response(response, :created)
    else
      json_response({message: failure_message}, :unprocessable_entity)
    end
  end

  private

  def failure_message
    if credit_adjuster.bundle && credit_adjustment < 0
      "Not enough credits"
    elsif !credit_adjuster.bundle
      "No bundle found, please create a new one for this customer"
    else
      "Request could not be processed"
    end
  end

  def credit_adjuster
    @_credit_adjuster ||= CreditAdjuster.new(
      user: current_user,
      customer_reference: customer_reference,
      product: product,
      credit_adjustment: credit_adjustment)
  end

  def credit_counter
    @_credit_counter ||= CreditCounter.count(
      user: current_user,
      customer_reference: customer_reference,
      product: product)
  end

  def customer_reference
    credit_adjustment_params[:customer_reference]
  end

  def credit_adjustment
    credit_adjustment_params[:credit_adjustment]
  end

  def product
    credit_adjustment_params[:product]
  end

  def credit_adjustment_params
    params.permit(:customer_reference, :product, :credit_adjustment)
  end
end
