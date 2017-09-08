class CreateJoinTableUserMovie < ActiveRecord::Migration
  def change
    create_join_table :users, :movies do |t|
      t.boolean :watched
      t.boolean :favorite
    end
  end
end
