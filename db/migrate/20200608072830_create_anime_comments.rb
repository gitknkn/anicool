class CreateAnimeComments < ActiveRecord::Migration[5.2]
  def change
    create_table :anime_comments do |t|

      t.text :comment
      t.integer :user_id
      t.integer :anime_id

      t.timestamps
    end
  end
end
