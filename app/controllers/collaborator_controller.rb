class CollaboratorController < ApplicationController

  @selected_collaborator = -1

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.new
    @collaborator.wiki_id = @wiki.id
    @collaborator.user_id = @user.id
    if @collaborator.save
      redirect_to wiki_path(@wiki), notice: "Collaborator was added successfully."
    else
      redirect_to wiki_path(@wiki), notice: "Error adding collaborator."
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
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end  

end
