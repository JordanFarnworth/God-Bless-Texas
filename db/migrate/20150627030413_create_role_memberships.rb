class CreateRoleMemberships < ActiveRecord::Migration
  def change
    create_table :role_memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.string :state

      t.timestamps null: false
    end
  end
end
