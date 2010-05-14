class ObservationStatesController < ApplicationController
  filter_resource_access
  
  # GET /observation_states
  # GET /observation_states.xml
  def index
    @observation_states = ObservationState.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @observation_states }
    end
  end

  # GET /observation_states/new
  # GET /observation_states/new.xml
  def new
    @observation_state = ObservationState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @observation_state }
    end
  end

  # GET /observation_states/1/edit
  def edit
    @observation_state = ObservationState.find(params[:id])
  end

  # POST /observation_states
  # POST /observation_states.xml
  def create
    @observation_state = ObservationState.new(params[:observation_state])

    respond_to do |format|
      if @observation_state.save
        flash[:notice] = 'ObservationState was successfully created.'
        format.html { redirect_to(observation_state_observation_cities_url(@observation_state)) }
        format.xml  { render :xml => @observation_state, :status => :created, :location => @observation_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @observation_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /observation_states/1
  # PUT /observation_states/1.xml
  def update
    @observation_state = ObservationState.find(params[:id])

    respond_to do |format|
      if @observation_state.update_attributes(params[:observation_state])
        flash[:notice] = 'ObservationState was successfully updated.'
        format.html { redirect_to(observation_state_observation_cities_url(@observation_state)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @observation_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /observation_states/1
  # DELETE /observation_states/1.xml
  def destroy
    @observation_state = ObservationState.find(params[:id])
    @observation_state.destroy

    respond_to do |format|
      format.html { redirect_to(observation_states_url) }
      format.xml  { head :ok }
    end
  end
end
