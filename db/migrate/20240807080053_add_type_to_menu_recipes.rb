class AddTypeToMenuRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_recipes, :temperature, :string
  end
end
