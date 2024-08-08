module Api
  module V1
    class MenuRecipeController < ApplicationController
      def save_recipe_item
        recipe_item = MenuRecipeItem.new(title: params[:title], image: '')
        if recipe_item.save
          render json: recipe_item, status: :ok
        else
          render json: recipe_item.errors, status: :internal_server_error
        end
      end

      def save_menu_recipe
        menu = Menu.find(params[:menuId])
        item = MenuRecipeItem.find_or_create_by(:title => params[:name])

        menu_recipe = menu.menu_recipes
                          .create({
                                    :menu_id => menu.id,
                                    :item_id => item.id,
                                    :amount => params[:amount],
                                    :order => menu.menu_recipes.length,
                                    :temperature => "ICE"
                                  })

        if menu_recipe.save
          render json: {
            :id => menu_recipe.id,
            :name => item.title,
            :order => menu_recipe.order,
            :amount => menu_recipe.amount,
            :image => item.image
          }, status: :ok
        else
          render json: menu_recipe.errors, status: :iternal_server_error
        end
      end

      def update_menu_recipes
        params[:items].each do |item|
          MenuRecipe.update(item[:id], {
            :order => item[:order],
            :amount => item[:amount]
          })
        end

        render status: :no_content
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
            :id => recipe.id,
            :name => recipe_item.title,
            :order => recipe.order,
            :amount => recipe.amount,
            :image => recipe_item.image
          }
        end.sort_by { |item| item[:order] }
        render json: items, status: :ok
      end

      def get_recipe_names
        item_names = MenuRecipeItem
                      .where('title LIKE :prefix', prefix: "#{params[:keyword]}%")
                      .pluck(:title)
        render json: item_names, status: :ok
      end

      def delete_recipe
        destroy = MenuRecipe.destroy(params[:recipeId])
        if destroy
          render status: :no_content
        else
          render status: :internal_server_error
        end
      end
    end
  end
end