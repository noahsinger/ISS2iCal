class ObservationOpportunitiesController < ApplicationController
  filter_resource_access
  before_filter :load_state, :load_city
  
  def load_state
    @observation_state = ObservationState.find params[:observation_state_id]
  end
  
  def load_city
    @observation_city = ObservationCity.find params[:observation_city_id]
  end
  
  # GET /observation_opportunities
  # GET /observation_opportunities.xml
  def index
    @observation_opportunities = @observation_city.observation_opportunities.find :all, :order => '"when" asc'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @observation_opportunities }
      format.ics { render :text => @observation_city.to_ical}
    end
  end

  # GET /observation_opportunities/1
  # GET /observation_opportunities/1.xml
  def show
    @observation_opportunity = @observation_city.observation_opportunities.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @observation_opportunity }
    end
  end

  # DELETE /observation_opportunities/1
  # DELETE /observation_opportunities/1.xml
  def destroy
    @observation_opportunity = @observation_city.observation_opportunities.find(params[:id])
    @observation_opportunity.destroy

    respond_to do |format|
      format.html { redirect_to(observation_state_observation_city_observation_opportunities_url(@observation_state,@observation_city)) }
    end
  end
end
