class ChangeVipIntoIntegerForCustomer < ActiveRecord::Migration
  def up
    change_column :customers, :vip, :integer
  end
  
  def down
    change_column :customers, :vip, :string
  end
end
