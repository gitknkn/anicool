class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :anime

  validates :anime_id, uniqueness: { scope: :user_id } #同じ組み合わせのidを防ぐ

end
