class DevelopersController < ApplicationController

  before_action :get_developer_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @developers = Developer.all
    render json: { developers: @developers }
  end

  def show
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

  def update
    if @developer.update developer_params
      head :no_content
    else
      render json: { errors: @developer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @developer.destroy
    head :no_content
  end


  private


  def get_developer_by_id
    @developer = Developer.find params[:id]
  end

  def developer_params
    params.require(:developer).permit(:username, :email, :password)
  end
end
