class CreateFantasyDrafts < ActiveRecord::Migration
  def self.up
    create_table :fantasy_drafts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :fantasy_drafts
  end
end
