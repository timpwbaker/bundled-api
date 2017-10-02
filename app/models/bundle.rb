class Bundle < ApplicationRecord
  belongs_to :user

  validates :starting_credits, presence: true
  validates :remaining_credits, presence: true
  validates :product, presence: true
  validates :customer_reference, presence: true
end
