class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :permissions
      t.string :state

      t.timestamps null: false
    end
  end
end
