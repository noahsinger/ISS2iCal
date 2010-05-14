class ObservationOpportunity < ActiveRecord::Base
  belongs_to :observation_city
  
  def remove_if_past
    self.destroy if self.when < Time.now
  end
  
  def to_ical_event
    event = Icalendar::Event.new
  	event.klass       "PUBLIC"
    # event.custom_property( "DTSTART;VALUE=DATE", self.when.strftime("%Y%m%d").to_i ) #for all day events
    event.dtstart     DateTime.civil(self.when.utc.strftime("%Y").to_i, self.when.utc.strftime("%m").to_i, self.when.utc.strftime("%d").to_i, self.when.utc.strftime("%H").to_i, self.when.utc.strftime("%M").to_i)
    event.dtend       DateTime.civil(self.when.utc.strftime("%Y").to_i, self.when.utc.strftime("%m").to_i, self.when.utc.strftime("%d").to_i, self.when.utc.strftime("%H").to_i, (self.when.utc.strftime("%M").to_i) + self.duration)
  	event.summary     self.title
  	event.description "Duration: #{self.duration} minutes\nMaximum Elevation: #{self.elevation} degrees\nApproach: #{self.approach}\nDeparture: #{self.departure}"
  	event.location    "#{self.observation_city.name}, #{self.observation_city.observation_state.name}"
  	event.dtstamp     self.created_at.to_datetime
  	event.uid         "observation_opportunity-#{self.id.to_s}"
  	event.sequence    0
  	
  	event.alarm do
      action        "AUDIO" #EMAIL and DISPLAY are other options
      summary       "#{event.summary} in 5 minutes"
      trigger       "-PT5M" # 5 minutes before
    end
  	
  	event
  end
end
