class CreateMotivations < ActiveRecord::Migration
  def change
    create_table :motivations do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :motivations, [:user_id, :created_at]
  end
end
