class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :logo, :string
    add_column :users, :gender, :string
  end
end
