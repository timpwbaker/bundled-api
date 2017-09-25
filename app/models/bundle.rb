class Bundle < ApplicationRecord
  belongs_to :user

  validates :starting_credits, presence: true
  validates :remaining_credits, presence: true
  validates :product, presence: true
  validates :product, uniqueness: { scope: :user_id }
  validates :customer_reference, presence: true, uniqueness: true
  validates :customer_reference, uniqueness: true
end
