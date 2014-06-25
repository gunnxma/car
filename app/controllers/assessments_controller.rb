class AssessmentsController < ApplicationController
  def index
    @q = CarInfo.search(params[:q])
    @cars = @q.result.paginate(:page => params[:page]).order(:addtime)
  end
  
  def new
    @car = CarInfo.new
  end
end
