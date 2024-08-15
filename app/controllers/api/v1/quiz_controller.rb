module Api
  module V1
    class QuizController < ApplicationController
      def get_menu_problem
        menu = Menu.find(Menu.pluck(:id).sample)
        temperature = %w[ICE HOT].sample

        items = menu.menu_recipes.joins(:menu_recipe_item)
                    .select(
                      'menu_recipes.id',
                      'menu_recipe_items.id',
                      'menu_recipe_items.title',
                      'menu_recipes.amount'
                    )
                    .where('menu_recipes.temperature = ?', temperature)
                    .order(:order)

        render json: {
          menu: {
            id: menu.id,
            title: menu.title,
            image: menu.image,
          },
          recipes: {
            temperature: temperature,
            items: items
          }
        }
      end
    end
  end
end
