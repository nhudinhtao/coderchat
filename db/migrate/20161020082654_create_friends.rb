class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
