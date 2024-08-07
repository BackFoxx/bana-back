class CreateMenuRecipeItems < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_recipe_items do |t|
      t.string :title

      t.timestamps
    end
  end
end
