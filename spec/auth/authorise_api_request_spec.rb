require "rails_helper"

RSpec.describe AuthoriseApiRequest, ".call" do
  context "Valid request" do
    it "returns a user object" do
      user = FactoryGirl.create :user
      header = { "Authorization" => token_generator(user.id) }
      valid_request_object = AuthoriseApiRequest.new(header)

      result = valid_request_object.call
      expect(result[:user]).to eq user
    end
  end

  context "Invalid request - missing a token" do
    it "Raises a MissingToken error" do
      invalid_request_object = AuthoriseApiRequest.new({})

      expect{ invalid_request_object.call }
        .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
    end
  end

  context "Invalid request - invalid token" do
    it "Raises a MissingToken error" do
      header = { "Authorization" => token_generator(19878) }
      invalid_request_object = AuthoriseApiRequest.new(header)

      expect{ invalid_request_object.call }
        .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
    end
  end

  context "Invalid request - expired token" do
    it "Raises an invalid token error" do
      user = FactoryGirl.create :user
      header = { "Authorization" => expired_token_generator(user.id) }
      invalid_request_object = AuthoriseApiRequest.new(header)

      expect{ invalid_request_object.call }
        .to raise_error(JWT::ExpiredSignature, /Signature has expired/)
    end
  end
end
