class CreateFantasyLeagues < ActiveRecord::Migration
  def self.up
    create_table :fantasy_leagues do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fantasy_leagues
  end
end
