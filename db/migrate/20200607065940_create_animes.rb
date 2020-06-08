class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|

      t.string :title
      t.string :main
      t.string :subbody
      t.string :image_id
      t.integer :user_id

      t.datetime :created_at
      t.datetime :updated_at

      
      t.timestamps
    end
  end
end
