namespace :update do
  desc "Update all rss feeds"
  task :feeds => :environment do
    ObservationState.all.each do |state|
      state.observation_cities.each do |city|
        val = city.update_from_feed
        if val == 0
          puts "Update failed for #{city.name}, #{city.observation_state.name} (#{val})"
        end
                  
        if val == true
          puts "Update suceeded for #{city.name}, #{city.observation_state.name} (#{val})"
        end
      end
    end
  end
end