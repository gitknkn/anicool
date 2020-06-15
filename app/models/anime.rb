class Anime < ApplicationRecord

  belongs_to :user
  has_many :anime_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image

  validates :title, presence: true, length: { in: 2..30}
  validates :main, presence: true, length: { in: 2..30}
  validates :subbody, presence: true, length: { maximum: 150 }

  def self.search(search)
    if search
      Anime.where(['title LIKE ?', "%#{search}%"])
    else
      Anime.all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
