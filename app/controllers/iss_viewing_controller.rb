class IssViewingController < ApplicationController
  def index
    @states = ObservationState.all :include => :observation_cities
  end
  
  def show
    @observation_city = ObservationCity.find params[:id]
    @observation_opportunities = @observation_city.observation_opportunities.find :all, :order => '"when" asc'

    respond_to do |format|
      format.ics { render :text => @observation_city.to_ical}
    end
  end
end
