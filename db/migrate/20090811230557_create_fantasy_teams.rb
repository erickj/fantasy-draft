class CreateFantasyTeams < ActiveRecord::Migration
  def self.up
    create_table :fantasy_teams do |t|
      t.string :name
      t.string :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :fantasy_teams
  end
end
