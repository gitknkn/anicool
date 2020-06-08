class Anime < ApplicationRecord

  belongs_to :user
  attachment :image 

end
