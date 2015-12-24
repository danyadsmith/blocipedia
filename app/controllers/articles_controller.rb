class ArticlesController < ApplicationController

  before_action :load_wiki
  before_action :load_article, except: [:new, :create]

  def index
    @articles = Article.all
    authorize @wiki
  end

  def show
    authorize @wiki
  end

  def new
    @article = Article.new
    authorize @wiki
  end

  def create
    @article = @wiki.articles.build(article_params)
    authorize @wiki
    if @article.save
      redirect_to [@wiki, @article], notice: "Article was created successfully."
    else
      flash[:error] = "Error creating article. Please try again."
      render :new
    end    
  end

  def edit
    authorize @wiki
  end

  def update
    authorize @wiki
    @article.assign_attributes(article_params)
    @article.slug = params[:title]

    if @article.save
      redirect_to [@wiki, @article], notice: "Article was updated successfully."
    else
      flash[:error] = "Error updating article. Please try again."
      render :new
    end     
  end

  def destroy
    authorize @wiki
    if @article.destroy
      redirect_to [@wiki], notice: "Article was deleted."
    else
      flash[:error] = "Error deleting article. Please try again."
      render :show
    end       
  end

  private

  def load_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def load_article
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end  
end
