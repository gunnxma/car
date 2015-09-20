class AddYaochiToCarProperty < ActiveRecord::Migration
  def change
  	add_column :car_properties, :yaochi, :string
  end
end
