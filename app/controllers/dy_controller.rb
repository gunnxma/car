class DyController < ApplicationController
	before_filter :check_power
  def index
    if current_user.id == 1
      @q = CarInfo.where("saletype = '抵押'").search(params[:q])
    else
      #@q = CarInfo.where("status > 0 and status < 3 and user_id = ?", current_user.id).search(params[:q])
      @q = CarInfo.where("saletype = '抵押'").search(params[:q])
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
    #@cars = CarInfo.where("status > 0").order(id: :desc)
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def dy_start
  	car = CarInfo.find(params[:id])
  	if car.status < 0
  		car.status = 0
  		car.save
  	end
  	redirect_to dy_index_path
  end

  def dy_end
  	car = CarInfo.find(params[:id])
  	if car.status == 0
  		car.status = -1
  		car.save
  	end
  	redirect_to dy_index_path
  end
end
