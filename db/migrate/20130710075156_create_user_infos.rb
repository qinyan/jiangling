class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table(:user_infos, :id => false) do |t|
      t.string :user_id
      t.text :contact
      t.timestamps
    end
    add_index :user_infos, :user_id, :index => true
  end
end
