class BundlesController < ApplicationController
  before_action :set_bundle, only: [:show, :update, :destroy]
  def index
    @bundles = Bundle.all
    json_response(@bundles)
  end

  def create
    @bundle = Bundle.create!(bundle_params
      .merge(user_id: current_user.id))
    response = { "product":@bundle.product, 
                 "customer_reference":@bundle.customer_reference,
                 "starting_credits":@bundle.starting_credits,
                 "remaining_credits":@bundle.remaining_credits }
    json_response(response, :created)
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
                  :product,
                  :id,
                  :customer_reference)
  end

  def set_bundle
    @bundle = Bundle.find(params[:id])
  end
end
