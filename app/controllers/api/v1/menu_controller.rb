module Api
  module V1
    class MenuController < ApplicationController
      def get_menus
        menus = Menu.all
        render json: menus, status: :ok
      end

      def get_keywords
        menus = Menu.find(params[:menuId])
        render json: menus.menu_keywords, status: :ok
      end

      def delete_keyword
        MenuKeyword.find(params[:keywordId]).destroy
        render status: :no_content
      end

      def save_menu
        param = params.permit(:title, :image)
        menu = Menu.new(param)

        if !menu.save
          render json: {
            message: '메뉴 저장에 실패했습니다.',
            data: menu.errors
          }, status: :unprocessable_entity
        end

        menu.menu_keywords.create(keyword: menu.title)

        render json: menu, status: :ok
      end

      def save_menu_keyword
        param = params.permit(:keyword)
        menu = Menu.find(params[:menuId])
        keyword = menu.menu_keywords.create(keyword: param[:keyword])

        if keyword.persisted?
          render json: keyword, status: :ok
        else
          render json: {
            data: keyword.errors
          }, status: :bad_request
        end
      end

      def auto_search
        keyword = params[:keyword]
        menus = Menu.joins(:menu_keywords)
                    .where('menu_keywords.keyword LIKE ?', "#{keyword}%")
                    .distinct

        found_menus = menus.map do |menu|
          {
            id: menu.id,
            title: menu.title,
          }
        end

        render json: found_menus
      end

      def delete_menu
        Menu.find(params[:menuId]).destroy
        render status: :no_content
      end

      def update_menu_image
        menu = Menu.find(params[:menuId])
        menu.update(image: params[:image])
        render status: :ok
      end

      def get_menu_order_by_search_count
        render json: Menu.order(search_count: :desc)
            .limit(5), status: :ok
      end

    end
  end
end

