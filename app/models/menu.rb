class Menu < ApplicationRecord
  validates :title, presence: true, uniqueness: { message: "%{value}는 이미 저장된 메뉴입니다." }

  has_many :menu_keywords, dependent: :destroy
  has_many :menu_recipes, dependent: :destroy
end
