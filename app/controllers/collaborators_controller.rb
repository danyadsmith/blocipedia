class CollaboratorsController < ApplicationController

  attr_accessor :user_email

  @selected_collaborator = -1

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:email])
    if @user.nil?
      #flash no user
      redirect_to edit_wiki_path(@wiki), notice: "There is no user with that e-mail address. Please try again."
    elsif @user && Collaborator.where(user: @user, wiki: @wiki).first
      #flash already a collaborator
      redirect_to edit_wiki_path(@wiki), notice: "The user associated with that e-mail address is already a collaborator for this wiki."
    elsif Collaborator.create(user: @user, wiki: @wiki)
      redirect_to edit_wiki_path(@wiki), notice: "Collaborator added successfully."
    else
      #flash error
      redirect_to edit_wiki_path(@wiki), notice: "An unknown error occurred. Please try again."
    end 
  end

  def edit
  end

  def destroy
    @wiki = Wiki.find([params[:wiki_id]])
    #@user = User.find([params[:user_id]])
    @collaborator = Collaborator.find(params[:collaborator_id])
    if @collaborator.destroy
      redirect_to wiki_path(@wiki), notice: "Collaborator was deleted."
    else
      flash[:error] = "Error deleting collaborator. Please try again."
      render :show
    end      
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id, :user_email)
  end  

end
