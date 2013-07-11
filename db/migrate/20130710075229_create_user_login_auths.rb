class CreateUserLoginAuths < ActiveRecord::Migration
  def change
    create_table(:user_login_auths, :force => true)  do |t|
      t.string :user_id
      t.string :site
      t.string :site_uid
      t.text :info
      t.datetime :expired_at
      t.timestamps
    end
  end
end
