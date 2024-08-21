module Api
  module V1
    class QuizController < ApplicationController
      def get_menu_problem
        menu = get_quiz_menu

        temperature = menu.menu_recipes.pluck(:temperature).sample

        correct_recipes = menu.menu_recipes.joins(:menu_recipe_item)
                              .select(
                                'menu_recipes.id',
                                'menu_recipe_items.id',
                                'menu_recipe_items.title',
                                'menu_recipes.amount'
                              )
                              .where('menu_recipes.temperature = ?', temperature)
                              .order(:order)

        items = correct_recipes.map do |recipe|
          options = MenuRecipe
                      .joins(:menu_recipe_item)
                      .select(
                        'menu_recipes.id',
                        'menu_recipe_items.id',
                        'menu_recipe_items.title',
                        'menu_recipes.amount'
                      )
                      .where('menu_recipe_items.title != ?', recipe.title)
                      .order("RAND()")
                      .limit(4).to_a
          options = options.map do |option|
            parse_quiz_option(option, false)
          end
          options << parse_quiz_option(recipe, true)
          options.shuffle
        end

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

      private

      def get_quiz_menu
        if params['groupId'].nil?
          return Menu.find(Menu.pluck(:id).sample)
        end

        menu_groups = MenuGroup.where({ group_id: params['groupId'] })
        random_menu_id = menu_groups.pluck(:menu_id).sample
        Menu.find(random_menu_id)
      end

      def parse_quiz_option(recipe, is_answer)
        {
          id: recipe["id"],
          title: recipe["title"],
          amount: recipe["amount"],
          isAnswer: is_answer
        }
      end
    end
  end
end