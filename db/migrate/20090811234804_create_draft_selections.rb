class CreateDraftSelections < ActiveRecord::Migration
  def self.up
    create_table :draft_selections do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :draft_selections
  end
end
