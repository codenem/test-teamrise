class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :team, index: true
      t.timestamps
    end

    add_foreign_key :users, :teams
  end
end
