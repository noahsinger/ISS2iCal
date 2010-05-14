require 'mechanize'

namespace :update do
  desc "Update cities and states"
  task :locations => :environment do
    agent = WWW::Mechanize.new
    host = "http://spaceflight.nasa.gov"
    base_url = "#{host}/realdata/sightings/cities"
    agent.get("#{base_url}/skywatch.cgi?country=United+States")
    
    state_links = agent.page.search("center center center center a")
    states = state_links.map {|link| [link.text,link[:href]]}
    
    puts "#{states.size} states found"
    
    states.each do |name,uri|
      current_state = ObservationState.find_by_name( name ) || ObservationState.create( :name => name )
      agent.get("#{base_url}/#{uri}")
      city_links = agent.page.search("center center a")

      cities = city_links.map {|link| [link.text.scan( /(.*)\n\n/ )[0][0],link[:href]]}
      
      puts "#{cities.size} cities found in #{name}"
      
      cities.each do |name, uri|
        unless current_state.observation_cities.find_by_name( name )
          print "\tadding #{name}..."
          current_city = ObservationCity.new( :name => name )
          current_city.observation_state = current_state
          
          agent.get("#{base_url}/#{uri}")
          links = agent.page.search("a")
          city_feed_uri = links[3][:href]
          
          current_city.url = "#{host}#{city_feed_uri}"
          
          current_city.save
          puts "done"
        end
      end
    end
  end
end