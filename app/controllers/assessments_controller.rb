class AssessmentsController < ApplicationController
  before_filter :check_power
  layout "nohead", :only => [ :show ]
  
  def index
    if current_user.id == 1
      @q = CarInfo.where('status = 0 and saletype <> "抵押"').search(params[:q])
    else
      #@q = CarInfo.where("status = 0 and user_id = ?", current_user.id).search(params[:q])
      @q = CarInfo.where('status = 0 and saletype <> "抵押"').search(params[:q])
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
    #@cars = CarInfo.where(status: 0).order(id: :desc)
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def new
    @car = CarInfo.new
    @car.addtime = DateTime.now.strftime("%Y/%m/%d")
    @car.car_no = get_car_no
    @car.saletype = "寄售"
    @car.init_assocation
    
    if params[:from] == "depot"
      @car.status = 1
    else
      @car.status = 0
    end
    
    @series = nil
  end
  
  def show
    @car = CarInfo.find(params[:id])
  end
  
  def create
    @car = CarInfo.new(car_params)
    #@car.addtime = DateTime.now
    @car.user_id = current_user.id
    
    @car.set_multi_value(params[:business_info], params[:safety], params[:comfort], params[:function])
    
    @car.depot_time = DateTime.now if @car.status == 1
    
    if @car.save
      if @car.status == 1
        redirect_to depot_index_path
      else
        if @car.saletype == '抵押'
          redirect_to dy_index_path
        else
          redirect_to :action => :index
        end
      end
    else
      brand = Brand.where(:name => @car.brand).first
      @series = brand.series if brand
      render "new"
    end
  end
  
  def edit
    @car = CarInfo.find(params[:id])
    
    @car.init_assocation
    @car.addtime = @car.addtime.strftime("%Y/%m/%d") if @car.addtime
    @car.car_property.production_date = @car.car_property.production_date.strftime("%Y/%m/%d") if @car.car_property.production_date
    @car.car_property.registration_date = @car.car_property.registration_date.strftime("%Y/%m/%d") if @car.car_property.registration_date
    @car.car_property.inspection_expire = @car.car_property.inspection_expire.strftime("%Y/%m/%d") if @car.car_property.inspection_expire
    @car.car_property.compulsory_expire = @car.car_property.compulsory_expire.strftime("%Y/%m/%d") if @car.car_property.compulsory_expire
    @car.car_property.business_expire = @car.car_property.business_expire.strftime("%Y/%m/%d") if @car.car_property.business_expire
    
    brand = Brand.where(:name => @car.brand).first
    @series = brand.series if brand
  end
  
  def update
    @car = CarInfo.find(params[:id])
    old_price = @car.price_to_hash
    if @car.update_attributes(car_params)
      @car.set_multi_value(params[:business_info], params[:safety], params[:comfort], params[:function])
      @car.save
      
      describe = @car.price_change_describe(old_price)      
      PriceLog.create(:car_info_id => @car.id, :describe => describe, :reason => params[:reason], :addtime => DateTime.now, :user_id => current_user.id) unless describe.blank?
      
      redirect_to :action => :edit, :id => @car.id
    else
      render "edit"
    end
  end
  
  def destroy
    @car = CarInfo.find(params[:id])
    @car.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => :index
  end
  
  private
  
  def car_params
    #params.require(:car_info).permit!
    params.require(:car_info).permit(:addtime, :status, :car_no, :saletype, :depot_id, :brand, :series, :vin, :engineid, :platenumber, :models, :ownername, :ownerphone, :newsfrom, :cooperation_id, :location, :rating, :customer_offer, :evaluate_price, :procurement_price, :newcar_price, :suggested_price, :maintenance_budget, :selllimit_price, :price_hand, :description, :user_id, car_property_attributes: [:yaochi, :is_shuiben, :is_shuomingshu, :is_baoyangshouce, :jiao_bz, :four_record, :transmission, :cc, :cc_unit, :transfer_number, :production_date, :registration_date, :registration_province, :registration_city, :registration_district, :mileage, :maintenance_mileage, :color, :interior_color, :body_class, :emission_standard, :with_plate_number, :use_nature, :insurance_info, :inspection_expire, :compulsory_expire, :compulsory_company, :business_info, :business_expire, :business_company, :insurance_record], car_assess_attributes: [:assess_appearance, :assess_skeletons, :assess_interior, :assess_engine, :assess_transmission, :assess_comprehensive, :user_id], car_configuration_attributes: [:standard, :safety, :comfort, :function, :other])
  end
end
