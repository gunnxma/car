class CarInfosController < ApplicationController
  before_filter :check_power
  def show
    @car = CarInfo.find(params[:id])
  end

  def search
    @q = CarInfo.where("status > 0 and depot_id in (?)", current_user.depots_id).search(params[:q])

    @cars = @q.result.paginate(:page => params[:page]).order(addtime: :desc)

    if params[:q] && params[:q][:brand_cont]
      brand = Brand.where(:name => params[:q][:brand_cont]).first
      @series = brand.series if brand
    end
    
    respond_to do |format|
      format.html
    end
  end
end
