class PagesController < ApplicationController
  def index
    authorize :page
  end

  def about
    authorize :page
  end
end
