class AddFieldsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :price, :decimal, precision: 10, scale: 2
    add_column :products, :description, :text
    add_column :products, :stock, :integer, default: 0, null: false
    add_column :products, :active, :boolean, default: true, null: false
  end
end
