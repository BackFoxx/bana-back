class Api::V1::GroupController < ApplicationController
  def save_group
    group = Group.create({ name: params['name'], image: params['image'] })
    render json: group, status: 201
  end

  def get_groups
    groups = Group.all
    render json: groups, status: 200
  end

  def get_menus_in_group
    menu_ids = MenuGroup.where(group_id: params["groupId"])
                        .pluck(:menu_id)
    menus = Menu.where(id: menu_ids)
    render json: menus, status: 200
  end

  def save_menu_in_group
    MenuGroup.create({
                       group_id: params["groupId"],
                       menu_id: params["menuId"]
                     })
    render status: 201
  end
end
