class DevelopersController < ApplicationController

  def index
    @developers = Developer.all
    render json: { developers: @developers }
  end

  def show
    @developer = Developer.find params[:id]
    render json: { developer: @developer }
  end
end
