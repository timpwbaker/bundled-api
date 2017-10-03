require "rails_helper"

RSpec.describe "Authentication", "POST auth/login" do
  context "Valid request" do
    it "Returns an auth token" do
      user = create :user
      headers = valid_headers(user.id).except('Authorization')
      valid_credentials = {
        email: user.email,
        password: user.password
      }.to_json

      post '/auth/login', params: valid_credentials, headers: headers

      expect(json['auth_token']).not_to be nil
    end
  end

  context "Invalid request" do
    it "returns a failure message" do
      headers = invalid_headers.except('Authorization')
      invalid_credentials = {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json

      post '/auth/login', params: invalid_credentials, headers: headers

      expect(json['message']).to match(/Invalid credentials/)
    end
  end
end
