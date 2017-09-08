class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :runtime
      t.float :rate
      t.string :image
      t.text :plot
      t.string :poster

      t.timestamps null: false
    end
  end
end
