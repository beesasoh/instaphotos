class CommentsController < ApplicationController
  before_action :authenticate_user!

  expose :context, -> { context_object }

  def create
    @comment = context.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  def update
    respond_to do |format|
      if comment.update(comment_params)
        format.html do
          redirect_to context,
                      notice: 'Comment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: comment }
      else
        format.html { render :edit }
        format.json do
          render json: comment.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    comment.destroy
    respond_to do |format|
      format.html do
        redirect_to comments_url,
                    notice: 'Comment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end

    def context_object
      Post.find_by(id: params[:post_id]) if params[:post_id]
    end
end
