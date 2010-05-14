authorization do
  role :administrator do
    has_permission_on [:observation_states,:observation_cities,:observation_opportunities], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:users,:roles], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
end