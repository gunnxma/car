class CarAssess < ActiveRecord::Base
  belongs_to :car_info
  belongs_to :user
end
