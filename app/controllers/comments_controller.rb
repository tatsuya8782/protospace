class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @comment = Comment.create(content: comment_params[:content], prototype_id: comment_params[:prototype_id], user_id: current_user.id)
    prototype = Prototype.find(params[:prototype_id])
    @comments = prototype.comments.includes(:user)
    redirect_to "/prototypes/#{@comment.prototype.id}"
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
    # params.permit(:content, :prototype_id, :user_id)
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id])
  end

end
