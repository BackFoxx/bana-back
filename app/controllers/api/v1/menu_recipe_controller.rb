module Api
  module V1
    class MenuRecipeController < ApplicationController
      def save_recipe_item
        recipe_item = MenuRecipeItem.new(title: params[:title], image: '')
        if recipe_item.save
          render json: recipe_item, status: :ok
        else
          render json: recipe_item.errors, status: :unprocessable_entity
        end
      end

      def save_menu_recipe
        menu = Menu.find(params[:menuId])
        item = MenuRecipeItem.find(params[:itemId])

        menu_recipe = menu.menu_recipes
                          .create({
                                    :menu_id => menu.id,
                                    :item_id => item.id,
                                    :amount => params[:amount],
                                    :order => menu.menu_recipes.length,
                                    :temperature => params[:temperature]
                                  })

        if menu_recipe.save
          render json: menu_recipe, status: :ok
        else
          render json: menu_recipe.errors, status: :unprocessable_entity
        end
      end

      def get_menu_items
        menu = Menu.find(params[:menuId])
        items = menu.menu_recipes
                    .filter do
        |recipe|
          recipe.temperature = params[:temperature]
        end
                    .map do
        |recipe|
          recipe_item = MenuRecipeItem.find(recipe.item_id)
          {
            :id => recipe_item.id,
            :name => recipe_item.title,
            :order => recipe.order,
            :amount => recipe.amount,
            :image => recipe_item.image
          }
        end.sort_by { |item| item[:order] }
        render json: items, status: :ok
      end
    end
  end
end