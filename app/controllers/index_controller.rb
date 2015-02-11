class IndexController < ApplicationController
  before_filter :check_login, :only => [:index, :changepwd, :savechangepwd]
  before_filter :get_price_log, :only => [:index, :changepwd, :savechangepwd]
  layout "nohead", :only => [ :login, :checklogin ]

  def index
    @depot_count = CarInfo.where("status > 0 and status < 3").count
    @assess_count = CarInfo.where("addtime >= ? and addtime <= ?", Date.parse("#{Time.now.year}-#{Time.now.month}-1"), 1.months.since(Date.parse("#{Time.now.year}-#{Time.now.month}-1"))).count
    @selloff_count = CarInfo.where("selloff_time >= ? and selloff_time <= ?", Date.parse("#{Time.now.year}-#{Time.now.month}-1"), 1.months.since(Date.parse("#{Time.now.year}-#{Time.now.month}-1"))).count
    @customer_count = Customer.where("addtime >= ? and addtime <= ?", Date.parse("#{Time.now.year}-#{Time.now.month}-1"), 1.months.since(Date.parse("#{Time.now.year}-#{Time.now.month}-1"))).count
    @today_depot_count = CarInfo.where("depot_time >= ? and depot_time <= ?", Time.now.beginning_of_day, Time.now.end_of_day).count
    @today_assess_count = CarInfo.where("addtime >= ? and addtime <= ?", Time.now.beginning_of_day, Time.now.end_of_day).count
    @today_selloff_count = CarInfo.where("selloff_time >= ? and selloff_time <= ?", Time.now.beginning_of_day, Time.now.end_of_day).count
    @today_customer_count = Customer.where("addtime >= ? and addtime <= ?", Time.now.beginning_of_day, Time.now.end_of_day).count

    @diya_list = CarInfo.where("saletype = '抵押' and status >= 0").order(addtime: :desc)
    @followups = Followup.where("followupable_type = ? and user_id = ?", "Customer", current_user.id).paginate(:page => params[:page]).order(addtime: :desc).take(10)

    if current_user.id == 1
      @customers = Customer.all.take(10)
    else
      @customers = Customer.where("user_id = ?", current_user.id).take(10)
    end

    #hightcharts
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "近六个月销售数量，收购数量，客户录入数量统计表")

      categories = []
      sells = []
      buys = []
      customers = []
      6.times.each do |i|
        categories << i.month.ago.strftime('%Y-%m')
        sells << CarInfo.where(:selloff_time => i.month.ago.beginning_of_month..i.month.ago.end_of_month).count
        buys << CarInfo.where(:addtime => i.month.ago.beginning_of_month..i.month.ago.end_of_month).where('saletype <> "抵押"').count
        customers << Customer.where(:addtime => i.month.ago.beginning_of_month..i.month.ago.end_of_month).count
      end
      f.xAxis(:categories => categories)
      f.series(:name => "销售数量", :data => sells)
      f.series(:name => "收购数量", :data => buys)
      f.series(:name => "客户录入数量", :data => customers)
      
      f.yAxis [
        {:title => {:text => "数量"}, tickInterval: 1 },
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  end

  def login
    @user = User.new
  end

  def checklogin
    @user = User.new(user_params)
    check_user = User.where( "account = ? and pwd = ?", @user.account, @user.pwd).first
    if check_user
      cookies[:user_id] = check_user.id
      session[:log_time] = Time.now
      #cookies[:user_id] = { :value => check_user.id, :expires => Time.now + 10}
      redirect_to :action => :index
    else
      flash[:notice] = "用户名密码错误！"
      redirect_to :action => :login
    end
  end

  def logout
    cookies.delete(:user_id)
    redirect_to :action => :login
  end

  def changepwd
  end

  def savechangepwd
    if params[:old_pwd].empty? || params[:new_pwd].empty? || params[:confirm_pwd].empty?
      flash[:notice] = "请将密码输入完整"
      render "changepwd"
      return
    end
    if params[:new_pwd] != params[:confirm_pwd]
      flash[:notice] = "二次输入的新密码不一致"
      render "changepwd"
      return
    end
    if current_user.pwd != params[:old_pwd]
      flash[:notice] = "旧密码输入错误"
      render "changepwd"
      return
    end
    user = User.find(current_user.id)
    user.pwd = params[:new_pwd]
    user.save
    flash[:notice] = "密码修改成功"
    redirect_to action: :changepwd
  end

  private

  def check_login
    redirect_to :controller => :index, :action => :login unless current_user
  end

  def user_params
    params.require(:user).permit(:account, :pwd)
  end
end
