ActionController::Routing::Routes.draw do |map|
  map.resources :roles

  map.resources :user_sessions
  map.resources :users
  map.resources :iss_viewing
  map.resources :observation_states do |state|
    state.resources :observation_cities, :member => {:dump_and_reload => :get, :update_feed => :get}
    state.resources :observation_cities do |city|
      city.resources :observation_opportunities
    end
  end

  map.root :controller => "home"
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
