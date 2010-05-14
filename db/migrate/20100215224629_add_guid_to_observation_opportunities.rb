class AddGuidToObservationOpportunities < ActiveRecord::Migration
  def self.up
    add_column :observation_opportunities, :guid, :string
  end

  def self.down
    remove_column :observation_opportunities, :guid
  end
end
