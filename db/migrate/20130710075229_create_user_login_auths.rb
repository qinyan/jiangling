class CreateUserLoginAuths < ActiveRecord::Migration
  def change
    create_table :user_login_auths  do |t|
      t.integer :user_id
      # t.string :user_id
      t.string :site
      t.string :site_uid
      t.text :info
      t.datetime :expired_at
      t.timestamps
    end
  end
end
