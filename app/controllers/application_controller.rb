class ApplicationController < ActionController::Base
  before_filter :authenticate_request

  attr_reader :current_admin


  private


  def authenticate_request
    @current_admin = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_admin
  end
end
