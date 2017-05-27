class DevelopersController < ApplicationController

  before_action :get_developer_by_id, only: [:show, :edit]

  def index
    @developers = Developer.all
    render json: { developers: @developers }
  end

  def show
    render json: { developer: @developer }
  end

  def new
    @developer = Developer.new()
    render json: { developer: @developer }
  end

  def edit
    render json: { developer: @developer }
  end

  def create
    @developer = Developer.new developer_params
    if @developer.save
      head :created
    else
      render json: { errors: @developer.errors }, status: :unprocessable_entity
    end
  end


  private


  def get_developer_by_id
    @developer = Developer.find params[:id]
  end

  def developer_params
    params.require(:developer).permit(:username, :email, :password)
  end
end
