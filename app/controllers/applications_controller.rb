class ApplicationsController < ApplicationController

  before_action :get_developer_by_developer_id
  before_action :get_application_by_id, only: [:show, :edit, :update, :destroy]

  def index
    render json: { applications: @developer.applications, developer: @developer }
  end

  def show
    render json: { application: @application }
  end

  def new
    @application = Application.new(developer_id: @developer.id)
    render json: { application: @application }
  end

  def edit
    render json: { application: @application }
  end

  def create
    @application = Application.new application_params
    if @application.save
      head :created
    else
      render json: { errors: @application.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @application.update application_params
      head :no_content
    else
      render json: { errors: @application.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy
    head :no_content
  end


  private


  def get_developer_by_developer_id
    @developer = Developer.find params[:developer_id]
  end

  def get_application_by_id
    @application = Application.find params[:id]
  end

  def application_params
    params.require(:application).permit(:id, :name, :key, :description, :developer_id)
  end
end
