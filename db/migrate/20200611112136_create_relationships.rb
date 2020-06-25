class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follwer_id
      t.integer :following_id

      t.index [:follwer_id, :following_id], unique: true

      t.timestamps
    end
  end
end
