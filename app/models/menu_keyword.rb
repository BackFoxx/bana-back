class MenuKeyword < ApplicationRecord
  validates :keyword, uniqueness: { scope: :menu_id, message: "이미 해당 키워드로 등록되어 있습니다." }
  belongs_to :menu
end
