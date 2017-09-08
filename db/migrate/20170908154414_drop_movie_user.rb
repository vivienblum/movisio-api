class DropMovieUser < ActiveRecord::Migration
  def change
    drop_table :movie_users
  end
end
