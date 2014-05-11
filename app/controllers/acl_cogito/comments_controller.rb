class AclCogito::CommentsController < ApplicationController
  include AclCogito::Controllers::InternalHelpers
  include AclCogito::Controllers::Replies if AclCogito.accept_replies

  def index
    @comments = resource.comments.page(params[:page])
  end

  def create
    @comment = resource.comments.build(params[:comment])
    @comment.owner = current_commenter
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
        redirect_to(opinio_after_create_path(resource))
      end
    end
  end

  def destroy
    @comment = AclCogito.model_name.constantize.find(params[:id])

    if can_destroy_acl_cogito?(@comment)
      @comment.destroy
      set_flash(:notice, t('acl_cogito.messages.comment_destroyed'))
    else
      #flash[:error]  = I18n.translate('opinio.comment.not_permitted', :default => "Not permitted")
      logger.warn "user #{current_commenter} tried to remove a comment from another user #{@comment.owner.id}"
      render :text => "unauthorized", :status => 401 and return
    end

    respond_to do |format|
      format.js
      format.html { redirect_to( acl_cogito_after_destroy_path(@comment) ) }
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:owner_id, :commentable_id, :commentable_type, comment[:body])
  end
  
end