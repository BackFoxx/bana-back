class CreateMenuGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_groups do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
