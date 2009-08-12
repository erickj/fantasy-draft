class CreateFantasyPlayers < ActiveRecord::Migration
  def self.up
    create_table :fantasy_players do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :fantasy_players
  end
end
