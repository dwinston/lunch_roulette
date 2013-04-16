class AddWantsLunchIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :wants_lunch
  end
end
