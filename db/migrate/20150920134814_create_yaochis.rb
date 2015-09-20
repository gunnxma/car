class CreateYaochis < ActiveRecord::Migration
  def change
    create_table :yaochis do |t|
      t.string :name

      t.timestamps
    end
  end
end
