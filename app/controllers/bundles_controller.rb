class BundlesController < ApplicationController
  before_action :set_bundle, only: [:show, :update, :destroy]
  def index
    @bundles = Bundle.all
    json_response(@bundles)
  end

  def create
    @bundle = Bundle.create!(bundle_params)
    json_response(@bundle, :created)
  end

  def show
    json_response(@bundle)
  end

  def update
    @bundle.update(bundle_params)
    head :no_content
  end

  def destroy
    @bundle.destroy
    head :no_content
  end

  private

  def bundle_params
    params.permit(:starting_credits,
                  :remaining_credits,
                  :user_id,
                  :product,
                  :id,
                  :customer_reference)
  end

  def set_bundle
    @bundle = Bundle.find(params[:id])
  end
end
