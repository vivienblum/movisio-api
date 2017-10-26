class MakeMovieUnique < ActiveRecord::Migration
  def change
    add_index :movies, [:title, :runtime, :year], unique: true
  end
end
