class AddMyIntroductionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :my_introdution, :string
    add_column :users, :my_photo, :string
  end
end
