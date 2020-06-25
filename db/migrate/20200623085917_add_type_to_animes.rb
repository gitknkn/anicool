class AddTypeToAnimes < ActiveRecord::Migration[5.2]
  def change
    add_column :animes, :type_anime, :integer, default: 0, null: false
  end
end
