class RemoveColumnFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :movies_checked_out_count, :integer, :default => 0
  end
end
