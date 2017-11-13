class ProfileController < ApplicationController
  expose :user, -> { User.find_by(username: params[:user_name]) }
  expose :posts, -> { user.posts.order('created_at desc') }

  def show; end
end
