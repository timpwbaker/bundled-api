require "rails_helper"

RSpec.describe "Credit Adjustment API" do
  context "Valid request - Reduce by 1" do
    it "Should reduce credit count by 1" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create :bundle,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 10
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference,
                 credit_adjustment: -1 }.to_json
      headers = valid_headers(user.id)

      post "/credit_adjustment", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["credit_adjustment"]).to eq(-1)
      expect(json["remaining_credits"]).to eq 9
    end
  end

  context "Valid request - Reduce by 2" do
    it "Should reduce credit count by 2" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create :bundle,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 10
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference,
                 credit_adjustment: -2 }.to_json
      headers = valid_headers(user.id)

      post "/credit_adjustment", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["credit_adjustment"]).to eq(-2)
      expect(json["remaining_credits"]).to eq 8
    end
  end

  context "Valid request - Not enough credits" do
    it "Should return error message" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create :bundle,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 0
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference,
                 credit_adjustment: -1 }.to_json
      headers = valid_headers(user.id)

      post "/credit_adjustment", params: params, headers: headers

      expect(response).to have_http_status(422)
      expect(json['message'])
          .to match(/Not enough credits/)
    end
  end

  context "Valid request - Add 1 credit to existing bundle" do
    it "returns success and details" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      FactoryGirl.create :bundle,
        customer_reference: customer_reference,
        user: user,
        product: "Tall Ladder",
        remaining_credits: 10
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference,
                 credit_adjustment: 1 }.to_json
      headers = valid_headers(user.id)

      post "/credit_adjustment", params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json["credit_adjustment"]).to eq 1
      expect(json["remaining_credits"]).to eq 11
    end
  end

  context "Valid request - Add one credit but no bundle" do
    it "returns failure and details" do
      user = FactoryGirl.create :user
      customer_reference = SecureRandom.hex
      params = { product: "Tall Ladder",
                 customer_reference: customer_reference,
                 credit_adjustment: 1 }.to_json
      headers = valid_headers(user.id)

      post "/credit_adjustment", params: params, headers: headers

      expect(response).to have_http_status(422)
      expect(json['message'])
          .to match(/No bundle found, please create a new one/)
    end
  end
end
