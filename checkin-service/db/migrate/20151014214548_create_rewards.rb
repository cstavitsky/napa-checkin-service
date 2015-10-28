class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :point_value
      t.integer :checkin_id
      t.integer :times_redeemed, default: 0
      t.timestamps
    end
  end
end
