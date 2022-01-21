class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :description
      t.string :method
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
