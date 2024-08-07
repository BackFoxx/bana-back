class CreateMenuKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_keywords do |t|
      t.string :keyword
      t.integer :menu_id

      t.timestamps
    end
  end
end
