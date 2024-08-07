class MenuRecipe < ApplicationRecord
  validates :menu_id, :item_id, :amount, :order, :temperature, presence: true
  validates :order, uniqueness: { scope: :menu_id, message: "순서가 잘못 등록되었습니다." }

  belongs_to :menu, foreign_key: 'menu_id', class_name: 'Menu'
  belongs_to :menu_recipe_item, foreign_key: :item_id, class_name: "MenuRecipeItem"
end
