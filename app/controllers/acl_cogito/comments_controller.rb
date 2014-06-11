class AclCogito::CommentsController < ApplicationController
  include AclCogito::Controllers::InternalHelpers
  include AclCogito::Controllers::Replies if AclCogito.accept_replies

  def index
    @comments = resource.comments.page(params[:page])
  end

  def discovery
    @discovery = resource.comments.where("created_at > ?", 2.month.ago).order("RAND()").limit(4)      
  end

  def create
    @comment = resource.comments.build(comment_params)
    @comment.owner_id = current_commenter.id
    if @comment.save
      flash_area = :notice
      message = t('acl_cogito.messages.comment_sent')
    else
      flash_area = :error
      message = t('acl_cogito.messages.comment_sending_error')
    end

    respond_to do |format|
      format.js
      format.html do
        set_flash(flash_area, message)
        redirect_to(acl_cogito_after_create_path(resource))
      end
    end
  end

  def destroy
    @comment = AclCogito.model_name.constantize.find(params[:id])

    if (current_commenter.id == @comment.owner_id)
      @comment.destroy
      flash_area = :notice
      message = t('acl_cogito.messages.comment_destroyed')
    else
      logger.warn "user #{current_commenter.id} tried to remove a comment from another user #{@comment.owner_id}"
      render :text => "unauthorized", :status => 401 and return
    end

    respond_to do |format|
      format.js
      format.html { redirect_to( acl_cogito_after_destroy_path(@comment) ) }
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:owner_id, :commentable_id, :commentable_type, :body)
  end
  
end