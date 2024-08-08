class MenuRecipe < ApplicationRecord
  validates :menu_id, :item_id, :order, :temperature, presence: true

  belongs_to :menu, foreign_key: :menu_id, class_name: 'Menu'
  belongs_to :menu_recipe_item, foreign_key: :item_id, class_name: "MenuRecipeItem"
end
