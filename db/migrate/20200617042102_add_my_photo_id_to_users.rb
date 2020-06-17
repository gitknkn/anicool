class AddMyPhotoIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :my_photo_id, :string
  end
end
