class ApplicationsController < ApplicationController

  before_action :get_developer_by_developer_id

  def index
    render json: { applications: @developer.applications, developer: @developer }
  end


  private


  def get_developer_by_developer_id
    @developer = Developer.find params[:developer_id]
  end
end
