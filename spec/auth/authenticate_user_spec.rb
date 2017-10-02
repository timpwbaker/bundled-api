require "rails_helper"

RSpec.describe AuthenticateUser, ".call" do
  context "Valid credentails" do
    it "Returns an auth token" do
      user = create :user
      valid_auth_object = AuthenticateUser.new(user.email, user.password)
      token = valid_auth_object.call
      expect(token).not_to be nil
    end
  end

  context "Invalid credentails" do
    it "Raises an authentication error" do
      invalid_auth_object = AuthenticateUser.new("Foo", "Bar")

      expect{ invalid_auth_object.call }
        .to raise_error(
          ExceptionHandler::AuthenticationError,
          /Invalid credentials/
      )
    end
  end
end
