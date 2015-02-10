class CarInfo < ActiveRecord::Base
  has_one :car_property, :dependent => :destroy
  has_one :car_assess, :dependent => :destroy
  has_one :car_configuration, :dependent => :destroy
  has_one :cooperation
  belongs_to :user
  has_many :price_logs
  has_many :car_photos
  has_many :repairs
  belongs_to :sell_user, :class_name => "User", :foreign_key => "sell_user_id"
  belongs_to :customer
  belongs_to :sell_way
  belongs_to :payment_method
  has_many :payments
  has_many :proceeds, :class_name => "Proceeds"
  has_many :followups, as: :followupable, :dependent => :destroy
  belongs_to :depot
  
  validates :brand, :presence => { :message => "品牌不能为空" }
  validates :series, :presence => { :message => "车系不能为空" }
  validates :models, :presence => { :message => "型号不能为空" }
  validates :addtime, :presence => { :message => "收购日期不能为空" }

  validate :dy_validation
 
  before_save :check_price
  
  accepts_nested_attributes_for :car_property, :car_assess, :car_configuration, :cooperation
  accepts_nested_attributes_for :followups, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
  def status_str
    if self.status
      ["待定", "在库", "在售", "已成交"][self.status]
    else
      "待定"
    end
  end
  
  def info
    "#{self.brand} #{self.series} #{self.models}"
  end
  
  def owner_info
    "#{self.ownername} #{self.ownerphone}"
  end
  
  def init_assocation
    self.car_property = CarProperty.new( :business_info => "" ) unless self.car_property
    self.car_assess = CarAssess.new unless self.car_assess
    self.car_configuration = CarConfiguration.new( :safety => "", :comfort => "", :function => "" ) unless self.car_configuration
  end
  
  def set_multi_value(business_info, safety, comfort, function)
    self.car_property.business_info = business_info.join(",") if business_info
    self.car_configuration.safety = safety.join(",") if safety
    self.car_configuration.comfort = comfort.join(",") if comfort
    self.car_configuration.function = function.join(",") if function
  end
  
  def check_price
    self.customer_offer = 0 unless self.customer_offer
    self.evaluate_price = 0 unless self.evaluate_price
    self.procurement_price = 0 unless self.procurement_price
    self.newcar_price = 0 unless self.newcar_price
    self.suggested_price = 0 unless self.suggested_price
    self.maintenance_budget = 0 unless self.maintenance_budget
    self.selllimit_price = 0 unless self.selllimit_price
    self.price_hand = 0 unless self.price_hand
  end
  
  def price_to_hash
    {
      :customer_offer => self.customer_offer,
      :evaluate_price => self.evaluate_price,
      :procurement_price => self.procurement_price,
      :newcar_price => self.newcar_price,
      :suggested_price => self.suggested_price,
      :maintenance_budget => self.maintenance_budget,
      :selllimit_price => self.selllimit_price,
      :price_hand => self.price_hand
    }
  end
  
  def price_change_describe(old_price)
    describe = ""
    describe += "客户报价由#{old_price[:customer_offer]}万变更为#{self.customer_offer}万," if old_price[:customer_offer] != self.customer_offer
    describe += "评估价格#{old_price[:evaluate_price]}万变更为#{self.evaluate_price}万," if old_price[:evaluate_price] != self.evaluate_price
    describe += "收购价格由#{old_price[:procurement_price]}万变更为#{self.procurement_price}万," if old_price[:procurement_price] != self.procurement_price
    describe += "新车指导价由#{old_price[:newcar_price]}万变更为#{self.newcar_price}万," if old_price[:newcar_price] != self.newcar_price
    describe += "建议售价由#{old_price[:suggested_price]}万变更为#{self.suggested_price}万," if old_price[:suggested_price] != self.suggested_price
    describe += "整备预算由#{old_price[:maintenance_budget]}万变更为#{self.maintenance_budget}万," if old_price[:maintenance_budget] != self.maintenance_budget
    describe += "销售限价由#{old_price[:selllimit_price]}万变更为#{self.selllimit_price}万," if old_price[:selllimit_price] != self.selllimit_price
    describe += "新车到手价由#{old_price[:price_hand]}万变更为#{self.price_hand}万," if old_price[:price_hand] != self.price_hand
    describe
  end

  def depot_day
    diff = Time.diff(self.depot_time, DateTime.now)
    diff[:year]*365 + diff[:month]*30 + diff[:week]*7 + diff[:day]
  end

  def sell_day
    diff = Time.diff(self.sell_time, DateTime.now)
    diff[:year]*365 + diff[:month]*30 + diff[:week]*7 + diff[:day]
  end

  def repair_costs
    costs = 0
    self.repairs.each do |r|
      costs += r.cost
    end
    costs / 10000
  end

  def payment_costs
    costs = 0
    self.payments.each do |r|
      costs += r.cost
    end
    costs / 10000
  end

  def proceeds_costs
    costs = 0
    self.proceeds.each do |r|
      costs += r.cost
    end
    costs / 10000
  end

  def profit_costs
    #self.proceeds_costs - self.payment_costs - self.repair_costs
    self.proceeds_costs - self.payment_costs
  end

  private

  def dy_validation
    if saletype == '抵押'
      if ownername.blank?
        errors[:saletype] << "抵押车辆必须填写车主姓名"
      end
      if ownerphone.blank?
        errors[:ownerphone] << "抵押车辆必须填写车主电话"
      end
    end
  end
  
end
