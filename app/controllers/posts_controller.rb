class PostsController < ApplicationController
  expose :posts, -> { Post.order('created_at desc') }
  expose :post

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    post = Post.new(post_params)

    respond_to do |format|
      if post.save
        format.html do
          redirect_to post,
                      notice: 'Post was successfully created.'
        end
        format.json { render :show, status: :created, location: post }
      else
        format.html { render :new }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if post.update(post_params)
        format.html do
          redirect_to post,
                      notice: 'Post was successfully updated.'
        end
        format.json { render :show, status: :ok, location: post }
      else
        format.html { render :edit }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post.destroy
    respond_to do |format|
      format.html do
        redirect_to posts_url,
                    notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
