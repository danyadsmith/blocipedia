class WikisController < ApplicationController
  before_action :load_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was created successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was updated successfully."
    else
      flash[:error] = "Error updating wiki. Please try again."
      render :new
    end    
  end

  def destroy
    if @wiki.destroy
      redirect_to @wiki, notice: "Wiki was deleted successfully."
    else
      flash[:error] = "Error deleting wiki. Please try again."
      render :new
    end
  end

  private

  def load_wiki
    @wiki = Wiki.find(params[:id])
  end

  def wiki_params
    params.require(:wiki).permit(:title, :description, :private)
  end
end
