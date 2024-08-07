class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.string :title
      t.integer :searchCount, default: 0
      t.binary :image

      t.timestamps
    end
  end
end
