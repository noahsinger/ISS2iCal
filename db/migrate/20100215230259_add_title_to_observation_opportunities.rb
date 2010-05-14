class AddTitleToObservationOpportunities < ActiveRecord::Migration
  def self.up
    add_column :observation_opportunities, :title, :string
  end

  def self.down
    remove_column :observation_opportunities, :title
  end
end
