Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :articles
    end
  end

  namespace 'api' do
    namespace 'v1' do
      get '/menus', to: 'menu#get_menus'
      post '/menus', to: 'menu#save_menu'
      delete '/menus/:menuId', to: 'menu#delete_menu'

      get '/menus/keywords/search', to: 'menu#auto_search'
      get '/menus/:menuId/keywords', to: 'menu#get_keywords'
      delete '/keywords/:keywordId', to: 'menu#delete_keyword'
      post '/menus/:menuId/keywords', to: 'menu#save_menu_keyword'

      get '/recipes/names', to: 'menu_recipe#get_recipe_names'
      post '/recipes', to: 'menu_recipe#save_recipe_item'
      post '/menus/:menuId/recipes', to: 'menu_recipe#save_menu_recipe'
      get '/menus/:menuId/recipes', to: 'menu_recipe#get_menu_items'
      patch '/menus/:menuId/recipes', to: 'menu_recipe#update_menu_recipes'
      delete '/menus/recipes/:recipeId', to: 'menu_recipe#delete_recipe'
    end
  end

end
