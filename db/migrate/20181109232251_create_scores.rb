class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :status, default: 0
      t.integer :points, default: 0
      t.integer :points_won, default: 0
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true

      t.timestamps null: false
    end
  end
end
