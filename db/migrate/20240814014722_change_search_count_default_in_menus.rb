class ChangeSearchCountDefaultInMenus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :menus, :search_count, 0
  end
end
