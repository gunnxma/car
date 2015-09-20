class AddFourrecordToCarProperty < ActiveRecord::Migration
  def change
  	add_column :car_properties, :four_record, :string
  end
end
