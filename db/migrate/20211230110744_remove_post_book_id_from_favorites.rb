class RemovePostBookIdFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :post_book_id, :integer
  end
end
