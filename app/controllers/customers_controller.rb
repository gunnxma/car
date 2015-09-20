class CustomersController < ApplicationController
  before_filter :check_power
  before_filter :sex, only: [:new, :create, :edit, :update]

  def index
    if current_user.id == 1
      @q = Customer.all.search(params[:q])
    else
      @q = Customer.where("user_id = ?", current_user.id).search(params[:q])
    end
    if request.format == :xls
      @customers = @q.result.order(addtime: :desc)
    else
      @customers = @q.result.paginate(:page => params[:page]).order(addtime: :desc)
    end
    if params[:q] && params[:q][:brand_cont]
      brand = Brand.where(:name => params[:q][:brand_cont]).first
      @series = brand.series if brand
    end
    #@customers = Customer.all.order(id: :desc)
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @customer = Customer.new
    @customer.customer_need = CustomerNeed.new
    @customer.customer_other = CustomerOther.new
    @customer.no = get_customer_no
    @customer.status = 0
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user_id = current_user.id
    @customer.addtime = DateTime.now
    if @customer.save
      redirect_to :action => :index
    else
      render "new"
    end
  end

  def edit
    @customer = Customer.find(params[:id])

    brand = Brand.where(:name => @customer.customer_need.brand).first
    @series = brand.series if brand
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      redirect_to :action => :edit, :id => @customer.id
    else
      render "edit"
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def followups
    #@followups = Followup.where("followupable_type = ? and user_id = ?", "Customer", current_user.id)
    @followups = Followup.where("followupable_type = ? and user_id = ?", "Customer", current_user.id).paginate(:page => params[:page]).order(addtime: :desc)
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => :index
  end

  private

  def sex
    @sex = SEX
  end

    def customer_params
      params.require(:customer).permit(:sort_id, :vip, :no, :name, :phone, :weixin, :address, :call_time, :call_type_id, :sex, :id_number, :birthday, :age_id, :industry_id, :duty_id, :income_id, :status, :plan_deal_time, :user_id, :addtime, :visit_date, :other, customer_need_attributes: [:brand, :series, :models, :brand_others, :color, :interior_color, :transmission, :car_sort_id, :cc_min, :cc_max, :cc_unit, :mileage_min, :mileage_max, :car_age_min, :car_age_max, :expectative_price_min, :expectative_price_max, :transfer_area, :platenumber_demand, :is_mortgage, :mortgage_description], customer_other_attributes: [:experience_id, :buy_reason_id, :undeal_reason, :seen_models, :fit_models, :newsfrom, :network_id, :tag_id, :business_stage_id])
    end
end
