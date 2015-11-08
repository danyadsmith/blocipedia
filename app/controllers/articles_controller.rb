class ArticlesController < ApplicationController

  before_action :load_wiki
  before_action :load_article

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = @wiki.articles.build(article_params)
    if @article.save
      redirect_to [@wiki, @article], notice: "Article was created successfully."
    else
      flash[:error] = "Error creating article. Please try again."
      render :new
    end    
  end

  def edit

  end

  def update
    @article.assign_attributes(article_params)

    if @article.save
      redirect_to [@wiki, @article], notice: "Article was updated successfully."
    else
      flash[:error] = "Error updating article. Please try again."
      render :new
    end     
  end

  def destroy
    if @article.destroy
      redirect_to [@wiki], notice: "Article was deleted."
    else
      flash[:error] = "Error deleting article. Please try again."
      render :show
    end       
  end

  private

  def load_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def load_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end  
end
