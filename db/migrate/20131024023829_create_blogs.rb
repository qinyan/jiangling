class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      # t.column :id, 'char(20) PRIMARY KEY'
      # t.string :user_id
      t.integer :user_id
      t.string :name
      t.string :intro
      t.text :content
      t.timestamps
    end
  end
end
