class CreateMenuRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_recipes do |t|
      t.integer :menu_id
      t.integer :item_id
      t.string :amount
      t.integer :order

      t.timestamps
    end
  end
end
