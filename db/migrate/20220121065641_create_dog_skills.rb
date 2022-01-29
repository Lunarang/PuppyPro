class CreateDogSkills < ActiveRecord::Migration
  def change
    create_table :dog_skills do |t|
      t.integer :dog_id
      t.integer :skill_id
      t.string :level, :default => "Novice"
      
      t.timestamps null: false
    end
  end
end
