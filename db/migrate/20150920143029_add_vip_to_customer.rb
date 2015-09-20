class AddVipToCustomer < ActiveRecord::Migration
  def change
  	add_column :customers, :vip, :string
  end
end
