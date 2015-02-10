class SellController < ApplicationController
  before_filter :check_power
  def index
    if current_user.id == 1
      @q = CarInfo.where("status = 2 and saletype <> '抵押'").search(params[:q])
    else
      #@q = CarInfo.where("status = 2 and user_id = ?", current_user.id).search(params[:q])
      @q = CarInfo.where("status = 2 and saletype<>'抵押'").search(params[:q])
    end
    if request.format == :xls
      @cars = @q.result.order(addtime: :desc)
    else
      @cars = @q.result.paginate(:page => params[:page]).order(addtime: :desc)
    end
    if params[:q] && params[:q][:brand_cont]
      brand = Brand.where(:name => params[:q][:brand_cont]).first
      @series = brand.series if brand
    end
    #@cars = CarInfo.where("status = 2").order(id: :desc)
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def add
    car = CarInfo.find(params[:id])
    car.status = 2 if car.status == 1
    car.sell_time = DateTime.now
    car.save
    redirect_to :action => :index
  end
end
