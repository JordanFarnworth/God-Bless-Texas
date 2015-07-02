class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.references :user, index: true
      t.text :message
      t.string :title

      t.timestamps null: false
    end
    add_foreign_key :suggestions, :users
  end
end
