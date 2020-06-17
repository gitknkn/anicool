class RemoveMyPhotoFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :my_photo, :string
  end
end
