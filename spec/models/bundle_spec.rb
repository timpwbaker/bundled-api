require 'rails_helper'

RSpec.describe Bundle, "associations" do
  it { should belong_to :user }
end

RSpec.describe Bundle, "validations" do
  it { should validate_presence_of :starting_credits }
  it { should validate_presence_of :remaining_credits }
  it { should validate_presence_of :product }
  it { should validate_presence_of :customer_reference }

  it { should validate_uniqueness_of(:customer_reference)
end
