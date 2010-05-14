class ObservationCitiesController < ApplicationController
  filter_resource_access
  
  before_filter :load_state
  
  def load_state
    @observation_state = ObservationState.find params[:observation_state_id]
    # @observation_state = ObservationState.find_by_name params[:observation_state_id].gsub( '-', ' ' )
  end
  
  # GET /observation_cities
  # GET /observation_cities.xml
  def index
    @observation_cities = @observation_state.observation_cities.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @observation_cities }
    end
  end

  # GET /observation_cities/new
  # GET /observation_cities/new.xml
  def new
    @observation_city = @observation_state.observation_cities.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @observation_city }
    end
  end

  # GET /observation_cities/1/edit
  def edit
    @observation_city = @observation_state.observation_cities.find(params[:id])
  end

  # POST /observation_cities
  # POST /observation_cities.xml
  def create
    @observation_city = @observation_state.observation_cities.build(params[:observation_city])

    respond_to do |format|
      if @observation_city.save
        flash[:notice] = 'ObservationCity was successfully created.'
        format.html { redirect_to(observation_state_observation_city_observation_opportunities_path(@observation_state,@observation_city)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /observation_cities/1
  # PUT /observation_cities/1.xml
  def update
    @observation_city = @observation_state.observation_cities.find(params[:id])

    respond_to do |format|
      if @observation_city.update_attributes(params[:observation_city])
        flash[:notice] = 'ObservationCity was successfully updated.'
        format.html { redirect_to(observation_state_observation_city_observation_opportunities_path(@observation_state,@observation_city)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /observation_cities/1
  # DELETE /observation_cities/1.xml
  def destroy
    @observation_city = @observation_state.observation_cities.find(params[:id])
    @observation_city.destroy

    respond_to do |format|
      format.html { redirect_to(observation_state_observation_cities_url(@observation_state)) }
      format.xml  { head :ok }
    end
  end
  
  def dump_and_reload
    @observation_city = @observation_state.observation_cities.find(params[:id])
    value = @observation_city.dump_and_reload
    flash[:notice] = "dump and reload returned #{value}"
    redirect_to(observation_state_observation_city_observation_opportunities_path(@observation_state,@observation_city))
  end
  
  def update_feed
    @observation_city = @observation_state.observation_cities.find(params[:id])
    value = @observation_city.update_from_feed
    flash[:notice] = "update returned #{value}"
    redirect_to(observation_state_observation_city_observation_opportunities_path(@observation_state,@observation_city))
  end
end