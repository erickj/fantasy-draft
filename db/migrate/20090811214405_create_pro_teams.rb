class CreateProTeams < ActiveRecord::Migration
  def self.up
    create_table :pro_teams do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :pro_teams
  end
end
