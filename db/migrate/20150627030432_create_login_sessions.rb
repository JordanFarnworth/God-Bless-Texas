class CreateLoginSessions < ActiveRecord::Migration
  def change
    create_table :login_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :key
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
