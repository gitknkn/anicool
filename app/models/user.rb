class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #パスワードの正確性を検証
        :registerable, #ユーザー登録や編集、削除
        :recoverable, #パスワードをリセット
        :rememberable, #ログイン情報を保存
        :validatable, #(emailのフォーマットなどのバリデーション)
        :omniauthable #sns認証

  attachment :my_photo
  has_many :animes, dependent: :destroy 
  has_many :anime_comments, dependent: :destroy
  has_many :favorites ,dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :name, presence: true,length: { in: 1..40 }
  validates :email, uniqueness: true
  

  # フォローしているかどうかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # フォローする時のメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォロー外す時のメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # データーベースから情報を探し、データーがなければ、作成する
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

end
