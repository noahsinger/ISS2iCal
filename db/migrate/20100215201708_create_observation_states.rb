class CreateObservationStates < ActiveRecord::Migration
  def self.up
    create_table :observation_states do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :observation_states
  end
end
