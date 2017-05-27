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
    binding.pry
    if @developer.save
      head :no_content
    else
      render json: { errors: @developer.errors }, status: 422
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
