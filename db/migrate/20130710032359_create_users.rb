class CreateUsers < ActiveRecord::Migration
  def change
    create_table( :users, :id => false, :force => true ) do |t|
      t.column :id, 'char(20) PRIMARY KEY'
      t.string :username
      t.string :email
      t.string :password
      t.timestamps
    end
  end
  
end
