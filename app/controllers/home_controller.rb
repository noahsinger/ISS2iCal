class HomeController < ApplicationController
  def index
    
  end
  
  def test_flash_notice
    flash[:notice] = "This is a test flash notice"
    render :action => 'index'
  end
  
  def test_flash_error
    flash[:error] = "This is a test flash error"
    render :action => 'index'
  end
end
