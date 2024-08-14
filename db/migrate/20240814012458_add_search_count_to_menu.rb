class AddSearchCountToMenu < ActiveRecord::Migration[7.1]
  def change
    add_column :menus, :search_count, :integer
  end
end
