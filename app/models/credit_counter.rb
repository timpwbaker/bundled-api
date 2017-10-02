class CreditCounter
  def self.count(user:, customer_reference:, product:)
    new(user, customer_reference, product).count
  end

  def initialize(user, customer_reference, product)
    @user = user
    @customer_reference = customer_reference
    @product = product
  end

  def count
    bundles.inject(0){ |sum, object| sum + object.remaining_credits}
  end

  private

  attr_reader :user, :customer_reference, :product

  def bundles
    user.bundles
      .where(customer_reference: customer_reference)
      .where(product: product)
  end
end
