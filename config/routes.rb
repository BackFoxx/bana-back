Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :articles
    end
  end

  namespace 'api' do
    namespace 'v1' do
      get '/menus', to: 'menu#get_menus'
      get '/menus/:menuId/keywords', to: 'menu#get_keywords'
      get '/menus/keywords/search', to: 'menu#auto_search'
      delete '/keywords/:keywordId', to: 'menu#delete_keyword'
      post '/menus', to: 'menu#save_menu'
      post '/menus/:menuId/keywords', to: 'menu#save_menu_keyword'
      delete '/menus/:menuId', to: 'menu#delete_menu'

      post '/recipes', to: 'menu_recipe#save_recipe_item'
      post '/menus/:menuId/recipes', to: 'menu_recipe#save_menu_recipe'
      get '/menus/:menuId/recipes', to: 'menu_recipe#get_menu_items'
    end
  end

end
