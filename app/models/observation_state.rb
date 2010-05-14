class ObservationState < ActiveRecord::Base
  has_many :observation_cities, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
    # "#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
