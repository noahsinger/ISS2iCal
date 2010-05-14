require 'icalendar'

class ObservationCity < ActiveRecord::Base
  belongs_to :observation_state
  has_many :observation_opportunities, :dependent => :destroy, :order => '\'when\''
  
  validates_presence_of :name
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def to_ical
    cal = Icalendar::Calendar.new

    # to appease Outlook
    cal.custom_property("METHOD","PUBLISH")
    
    cal.product_id = "-//dclicio.us//iCal 1.0//EN"
    cal.custom_property("X-WR-CALNAME;VALUE=TEXT", "Observation Opportunities for #{self.name}, #{self.observation_state.name}")
    cal.custom_property("X-WR-TIMEZONE;VALUE=TEXT", "US/Central")
    
    self.observation_opportunities.each do |op|
      event = op.to_ical_event
    	cal.add_event(event)
    end

    cal.to_ical
  end
  
  def dump_and_reload
    observation_opportunities.all.each {|op| op.destroy}
    update_from_feed
  end
  
  def update_from_feed
    # delete opportunities that have past
    observation_opportunities.all.each {|op| op.remove_if_past}
    
    # look at oldest opportunity and if it's more than 2 weeks old do the update
    if observation_opportunities.size == 0 or observation_opportunities.first.when < 2.weeks.ago
      feed = Feedzirra::Feed.fetch_and_parse(url)
      add_entries(feed.entries) unless feed == 0
    end
    # otherwise we have new enough info so skip
  end
  
  private

  def add_entries(entries)
    entries.each do |entry|
      op = ObservationOpportunity.find_by_guid entry.id
      unless op

        date = entry.summary.scan /Date: (\w+), (\w+) (\d+), (\d+)/
        month   = date[0][1]
        day     = date[0][2]
        year    = date[0][3]
        
        time = entry.summary.scan /Time: (\d+):(\d+) (\w+)/
        hours     = time[0][0]
        minutes   = time[0][1]
        ampm      = time[0][2]


        self.observation_opportunities.build (
          :title        => entry.title.scan( /[A-Z]+ Sighting/ )[0],
          :when         => DateTime.parse("#{year}-#{month}-#{day} #{hours}:#{minutes} #{ampm}"),
          :duration     => entry.summary.scan( /Duration:.*(\d+) minute/ )[0][0],
          :elevation    => entry.summary.scan( /Elevation: (\d+)/ )[0][0],
          :approach     => entry.summary.scan(/Approach: (\d+\w .*)+ /)[0][0],
          :departure    => entry.summary.scan(/Departure: (\d+\w .*)+ /)[0][0],
          :guid         => entry.id
        )
      end
    end
    
    save
  end
end
