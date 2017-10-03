class CreditAdjuster

  attr_reader :user, :customer_reference, :product, :credit_adjustment

  def initialize(user:, customer_reference:, product:, credit_adjustment:)
    @user = user
    @customer_reference = customer_reference
    @product = product
    @credit_adjustment = credit_adjustment
  end

  def adjust
    if bundle
      bundle.adjust_credits(credit_adjustment)
    else
      false
    end
  end

  def bundle
    user.bundles
      .where(customer_reference: customer_reference)
      .where(product: product)
      .first
  end
end
