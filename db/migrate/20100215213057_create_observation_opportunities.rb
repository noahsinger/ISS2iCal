class CreateObservationOpportunities < ActiveRecord::Migration
  def self.up
    create_table :observation_opportunities do |t|
      t.references :observation_city
      t.datetime :when
      t.integer :duration
      t.integer :elevation
      t.string :approach
      t.string :departure

      t.timestamps
    end
  end

  def self.down
    drop_table :observation_opportunities
  end
end
