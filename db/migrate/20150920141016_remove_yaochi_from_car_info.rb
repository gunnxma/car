class RemoveYaochiFromCarInfo < ActiveRecord::Migration
  def self.up		
		remove_column :car_infos, :yaochi    
	end    
	def self.down
		add_column :car_infos, :yaochi, :string 
	end 
end
