require 'rails_helper'


RSpec.describe CommentsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:insta_post) { FactoryBot.create(:post, user: user) }

  describe 'POST #create' do
    it 'creates a new Post' do
      expect {
        post :create, xhr: true, params: { comment: {text: "Comment text"}, post_id: insta_post.id  }
      }.to change(Post, :count).by(1)
    end
  end

end
