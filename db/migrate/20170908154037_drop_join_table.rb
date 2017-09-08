class DropJoinTable < ActiveRecord::Migration
  def change
    drop_join_table(:users, :movies)
  end
end
