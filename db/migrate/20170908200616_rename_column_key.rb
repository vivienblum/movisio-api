class RenameColumnKey < ActiveRecord::Migration
  def change
    rename_column :users_movies, :users_id, :user_id
    rename_column :users_movies, :movies_id, :movie_id
  end
end
