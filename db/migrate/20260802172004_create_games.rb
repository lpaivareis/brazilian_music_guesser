class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :player_name, null: false
      t.integer :score, null: false, default: 0
      t.string :status, null: false, default: "in_progress"

      t.timestamps
    end
    add_index :games, :status
    add_index :games, :score
  end
end
