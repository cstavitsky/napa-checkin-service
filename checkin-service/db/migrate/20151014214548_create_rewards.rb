class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :point_value
      t.integer :checkin_id

      t.timestamps
    end
  end
end