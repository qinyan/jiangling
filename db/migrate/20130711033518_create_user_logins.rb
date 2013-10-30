class CreateUserLogins < ActiveRecord::Migration
  def change
    create_table :user_logins do |t|
      # t.column :user_id, 'char(20) PRIMARY KEY'
      t.integer :user_id
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
