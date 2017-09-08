class DeleteImageToMovie < ActiveRecord::Migration
  def change
    remove_column :movies, :image, :string
  end
end
