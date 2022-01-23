class ChangeTrackersToDogskills < ActiveRecord::Migration
  def change
    rename_table :trackers, :dog_skills
    change_column :dog_skills, :level, :string, :default => "Novice"
  end
end
