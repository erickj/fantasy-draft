class CreateFantasyRosters < ActiveRecord::Migration
  def self.up
    create_table :fantasy_rosters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :fantasy_rosters
  end
end
