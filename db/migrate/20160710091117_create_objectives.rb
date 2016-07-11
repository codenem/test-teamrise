class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :title, null: false
      t.integer :progress_start, null: :false
      t.integer :progress_target, null: :false
      t.integer :progress_value, null: :false
      t.string :progress_unit
      t.timestamps
      # Nested set related columns
      t.references :owner, index: true
      t.references :parent, index: true
      t.integer :level, default: 0, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
    end

    add_foreign_key :objectives, :users, column: :owner_id
    add_foreign_key :objectives, :objectives, column: :parent_id
    add_index :objectives, [:progress_value, :progress_target]
  end
end
