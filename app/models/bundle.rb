class Bundle < ApplicationRecord
  belongs_to :user

  validates :starting_credits, presence: true, numericality: { greater_than: -1 }
  validates :remaining_credits, presence: true, numericality: { greater_than: -1 }
  validates :product, presence: true
  validates :customer_reference, presence: true

  def adjust_credits(adjustment)
    self.remaining_credits =  self.remaining_credits + adjustment
    self.save
  end
end
