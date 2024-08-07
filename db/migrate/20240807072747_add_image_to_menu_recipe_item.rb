class AddImageToMenuRecipeItem < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_recipe_items, :image, :string
  end
end
