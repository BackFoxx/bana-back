class MenuRecipeItem < ApplicationRecord
  validates :title, presence: true, uniqueness: { message: "이미 존재하는 레시피 아이템명입니다." }

  has_many :menu_recipes
end
