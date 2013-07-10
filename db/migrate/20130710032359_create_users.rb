class CreateUsers < ActiveRecord::Migration
  def change
    create_table( :users, :id => false ) do |t|
      t.column :id, 'char(20) PRIMARY KEY'
      t.string :name
      t.timestamps
    end
  end
  
end
