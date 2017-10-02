require "rails_helper"

RSpec.describe "Users API" do
  context "Valid request" do
    it "creates a user" do
      user = build :user
      headers = {"Content-Type" => "application/json" }
      valid_attributes = attributes_for(
        :user, password_confirmation: user.password)

      post '/signup', params: valid_attributes.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(json['message']).to match(/Account created successfully/)
      expect(json['auth_token']).not_to be_nil
    end
  end

  context "Invalid request" do
    it "does not create a new user" do
      headers = {"Content-Type" => "application/json" }

      post "/signup", params: {}, headers: headers

      expect(response).to have_http_status(422)
      expect(json['message'])
          .to match(/Validation failed/)
    end
  end
end
