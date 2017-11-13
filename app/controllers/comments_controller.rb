class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = context
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path }
        format.js
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json do
          render json: @comment.errors,
                 status: :unprocessable_entity
        end
      end
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

  def context
    Post.find_by(id: params[:post_id]) if params[:post_id]
  end
end
