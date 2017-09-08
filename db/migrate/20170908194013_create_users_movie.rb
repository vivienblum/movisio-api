class CreateUsersMovie < ActiveRecord::Migration
  def change
    create_table :users_movies do |t|
      t.references :users
      t.references :movies

      t.boolean :watched, default: false
      t.boolean :favorite, default: false
    end
  end
end
