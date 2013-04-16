class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :wants_lunch, default: false
      t.integer :num_lunches, default: 1

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :wants_lunch
  end
end
