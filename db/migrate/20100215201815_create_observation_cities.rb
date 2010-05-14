class CreateObservationCities < ActiveRecord::Migration
  def self.up
    create_table :observation_cities do |t|
      t.references :observation_state
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :observation_cities
  end
end
