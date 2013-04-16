class ChangeDefaultsForUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :wants_lunch, :num_lunches
      t.boolean :wants_lunch, default: true
      t.integer :num_lunches, default: 0
    end
  end
end
