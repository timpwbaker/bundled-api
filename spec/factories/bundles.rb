FactoryGirl.define do
  factory :bundle do
    user
    customer_reference { SecureRandom.hex }
    starting_credits { Faker::Number.between(40, 50) }
    remaining_credits { Faker::Number.between(30, 40) }
    product { Faker::Commerce.product_name }
  end
end
