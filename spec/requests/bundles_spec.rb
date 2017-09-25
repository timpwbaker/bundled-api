require 'rails_helper'

RSpec.describe "Bundles API", type: :request do
  describe "/bundles" do
    it "returns all the bundles" do
      user = FactoryGirl.create :user
      FactoryGirl.create_list :bundle, 3, user: user

      get '/bundles'

      expect(json).not_to be_empty
      expect(json.size).to eq 3
    end

    it "returns a 200 status" do
      user = FactoryGirl.create :user
      FactoryGirl.create_list :bundle, 3, user: user

      get '/bundles'

      expect(response).to have_http_status(200)
    end
  end

  describe "/bundles/:id" do
    context "The record exists" do
      it "returns a bundle" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user

        get "/bundles/#{bundle.id}"

        expect(json).not_to be_empty
        expect(json['id']).to eq bundle.id
      end

      it "returns 200 status" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user

        get "/bundles/#{bundle.id}"

        expect(response).to have_http_status(200)
      end
    end

    context "Record not found" do 
      it "returns 404 status code" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user

        get "/bundles/#{bundle.id + 1}"

        expect(response).to have_http_status(404)
      end

      it "returns an error" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user

        get "/bundles/#{bundle.id + 1}"

        expect(response.body).to match(/Couldn't find Bundle/)
      end
    end
  end

  describe "POST /bundles" do
    context "Request is valid" do
      it "creates a bundle" do
        user = FactoryGirl.create :user
        bundle_attributes = FactoryGirl.attributes_for(:bundle)
          .merge(user_id: user.id)

        post "/bundles", params: bundle_attributes

        expect(json['user_id']).to eq user.id
        expect(json['product']).to eq bundle_attributes[:product]
      end

      it "returns 201 status" do
        user = FactoryGirl.create :user
        bundle_attributes = FactoryGirl.attributes_for(:bundle)
          .merge(user_id: user.id)

        post "/bundles", params: bundle_attributes

        expect(response).to have_http_status(201)
      end
    end

    context "request is invalid" do
      it "returns a 422 response" do
        user = FactoryGirl.create :user

        post "/bundles", params: { user_id: user.id }

        expect(response).to have_http_status(422)
      end

      it "returns validation error" do
        user = FactoryGirl.create :user

        post "/bundles", params: { starting_credits: 30, user_id: user.id }

        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe "PUT /bundles/:id" do
    context "when the record exists" do
      it "updates the record" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user
        bundle_attributes = FactoryGirl.attributes_for(:bundle)
          .merge(user_id: user.id, id: bundle.id)

        put "/bundles/#{user.id}", params: bundle_attributes

        expect(response.body).to be_empty
      end

      it "returns 204" do
        user = FactoryGirl.create :user
        bundle = FactoryGirl.create :bundle, user: user
        bundle_attributes = FactoryGirl.attributes_for(:bundle)
          .merge(user_id: user.id, id: bundle.id)

        put "/bundles/#{user.id}", params: bundle_attributes

        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /bundles/:id" do
    it "returns 204" do
      user = FactoryGirl.create :user
      bundle = FactoryGirl.create :bundle, user: user

      delete "/bundles/#{bundle.id}"

      expect(response).to have_http_status(204)
    end
  end
end
