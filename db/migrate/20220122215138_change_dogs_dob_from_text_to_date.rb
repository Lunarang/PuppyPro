class ChangeDogsDobFromTextToDate < ActiveRecord::Migration
  def change
    change_table :dogs do |t|
      t.change :dob, :date
    end
  end
end
