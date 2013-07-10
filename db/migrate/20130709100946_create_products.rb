class CreateProducts < ActiveRecord::Migration
  def change
    create_table(:products, :id => false) do |t|
      t.column  :id, 'char(20) PRIMARY KEY'
      t.string  :name
      t.integer :price
      t.string  :image
      t.text    :description
      t.timestamps
    end
  end
end
