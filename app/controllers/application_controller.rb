class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  skip_before_action :authorize_request, only: :authenticate

  attr_reader :current_user

  private

  def authorize_request
    @current_user = (AuthoriseApiRequest.new(request.headers).call)[:user]
  end
end
