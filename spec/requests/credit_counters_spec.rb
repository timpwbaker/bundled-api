require "rails_helper"

RSpec.describe "Credit Count API", "/credit_counter" do
  context "Bundle exists - Has credits for product" do
    it "returns count of credits for that product available to the customer" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create_list :bundle, 3,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 10
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference }.to_json
      headers = valid_headers(user.id)

      post "/credit_counter", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["remaining_credits"]).to eq 30
    end
  end

  context "Bundle exists - Does not have valid credits" do
    it "returns a zero for remaining credits" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create_list :bundle, 3,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 0
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference }.to_json
      headers = valid_headers(user.id)

      post "/credit_counter", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["remaining_credits"]).to eq 0
    end
  end

  context "No bundle matching that criteria" do
    it "returns a zero for remaining credits" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference }.to_json
      headers = valid_headers(user.id)

      post "/credit_counter", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["remaining_credits"]).to eq 0
    end
  end
end
