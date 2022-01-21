class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :dog_id
      t.integer :skill_id
      t.string :level
      
      t.timestamps null: false
    end
  end
end
