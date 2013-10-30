class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      # t.column :user_id, 'char(20) PRIMARY KEY'
      t.text :contact
      t.timestamps
    end
  end
end
