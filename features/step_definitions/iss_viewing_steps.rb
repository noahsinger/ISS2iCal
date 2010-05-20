Given /^I have cities named (.+) in (.+)$/ do |city_names, state_name|
  state = ObservationState.create!(:name => state_name)
  city_names.split( ", " ).each do |city_name|
    city = state.observation_cities.build(:name => city_name)
    city.save
  end
end