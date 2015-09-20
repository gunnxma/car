class AddJiaobzToCarProperty < ActiveRecord::Migration
  def change  	
  	add_column :car_properties, :jiao_bz, :string
  end
end
