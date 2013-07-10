class CreateUserEmails < ActiveRecord::Migration
  def change
    create_table(:user_emails, :id => false)  do |t|
      t.string :user_id
      t.string :email
      t.string :password
      t.timestamps
    end
    add_index :user_emails, :user_id, :index => true
  end
end
