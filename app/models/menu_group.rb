class MenuGroup < ApplicationRecord
  belongs_to :menu, foreign_key: :menu_id, class_name: 'Menu'
  belongs_to :group, foreign_key: :group_id, class_name: 'Group'
end
