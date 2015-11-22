class WikisController < ApplicationController
  before_action :load_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.visible_to(current_user)
    authorize @wikis, @articles
  end

  def show
    authorize @wiki, @article
  end

  def new
    @wiki = Wiki.new
    authorize @wiki, @article
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki, @article
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was created successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
    authorize @wiki, @article
  end

  def update
    @wiki.assign_attributes(wiki_params)
    authorize @wiki, @article

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was updated successfully."
    else
      flash[:error] = "Error updating wiki. Please try again."
      render :new
    end 
       
  end

  def destroy
    authorize @wiki, @article

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
