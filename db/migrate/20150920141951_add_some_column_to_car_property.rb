class AddSomeColumnToCarProperty < ActiveRecord::Migration
  def change
  	add_column :car_properties, :is_shuiben, :string
  	add_column :car_properties, :is_shuomingshu, :string
  	add_column :car_properties, :is_baoyangshouce, :string
  end
end
