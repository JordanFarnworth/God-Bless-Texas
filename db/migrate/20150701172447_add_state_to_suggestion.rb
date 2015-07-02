class AddStateToSuggestion < ActiveRecord::Migration
  def change
    add_column :suggestions, :state, :string
  end
end
