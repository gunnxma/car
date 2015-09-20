class AddYaochiToCarInfo < ActiveRecord::Migration
  def change
  	add_column :car_infos, :yaochi, :string
  end
end
