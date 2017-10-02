require "rails_helper"

RSpec.describe ApplicationController, "#authorize_request" do
  context "Auth token is passed" do
    it "Sets the current user" do
      user = create :user
      valid_headers = valid_headers(user.id)
      allow(request).to receive(:headers).and_return valid_headers

      expect(ApplicationController.instance_eval { authorize_request}).to eq user
    end
  end

  context "Auth token is not passed" do
    invalid_headers = { 'Authorization' => nil }
    allow(request).to receive(:headers).and_return invalid_headers

    expect { ApplicationController.instance_eval { authorize_request } }
      .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
  end
end
