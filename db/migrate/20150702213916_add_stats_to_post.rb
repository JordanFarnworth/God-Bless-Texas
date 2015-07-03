class AddStatsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :stats, :text
  end
end
