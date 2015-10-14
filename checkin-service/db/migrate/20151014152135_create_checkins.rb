class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :user_id
      t.integer :location_id
      t.integer :points

      t.timestamps
    end
  end
end