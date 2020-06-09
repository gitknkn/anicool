class AnimeComment < ApplicationRecord

  validates :comment, presence: true
  belongs_to :user
  belongs_to :anime

end
