class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table(:user_infos, :id => false, :force => true) do |t|
      t.column :user_id, 'char(20) PRIMARY KEY'
      t.text :contact
      t.timestamps
    end
  end
end
