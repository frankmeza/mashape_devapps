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


  private


  def get_developer_by_id
    @developer = Developer.find params[:id]
  end
end
