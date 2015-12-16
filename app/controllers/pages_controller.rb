class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    authorize :page
  end

  def about
    authorize :page
  end
end
