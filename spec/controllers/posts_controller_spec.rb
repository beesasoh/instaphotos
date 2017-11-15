require 'rails_helper'
require 'rack/test'


RSpec.describe PostsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:insta_post) { FactoryBot.create(:post, user: user) }

  let(:valid_attributes) {
    {
      caption: 'Sample post caption',
      image:  Rack::Test::UploadedFile.new("#{Rails.root}/spec/photos/test.jpg", 'image/jpeg') 
    }
  }

  let(:invalid_attributes) {
    {
      caption: 'Sample post caption',
      image:  Rack::Test::UploadedFile.new("#{Rails.root}/spec/photos/test.txt", 'text')
    }
  }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: insta_post.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    context 'without logged in user' do
      it 'redirects to user login path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with logged in user' do
      it 'returns a success response' do
        sign_in(user)
        get :new
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    context 'without logged in user' do
      it 'redirects to user login path' do
        get :edit, params: { id: insta_post.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with logged in user' do
      before { sign_in(user) }

      it 'returns success when user owns post' do
        get :edit, params: { id: insta_post.to_param }
        expect(response).to be_success
      end

      it 'redirects to root when user does not own post' do
        new_user = FactoryBot.create(:user, email: "newuser@email.com")
        sign_in(new_user)

        get :edit, params: { id: insta_post.to_param }
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'POST #create' do
    context 'without logged in user' do
      it 'redirects to user login path' do
        post :create, params: {}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with logged in user' do
      before { sign_in(user) }

      context 'Valid params' do
        it 'creates a new Post' do
          expect {
            post :create, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it 'redirects to the created post' do
          post :create, params: { post: valid_attributes }
          expect(response).to redirect_to(Post.last)
        end

        it 'assigns new post to current user' do
          post :create, params: { post: valid_attributes }
          expect(Post.last.user.id).to eq(user.id)
        end
      end

      context 'Invalid params' do
        it "returns a success response" do
          post :create, params: { post: invalid_attributes }
          expect(response).to be_success
        end
      end

    end
  end

  describe 'PUT #update' do

    context 'without logged in user' do
      it 'redirects to user login path' do
        put :update, params: {id: insta_post.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with logged in user' do
      before { sign_in(user) }

      context 'with valid params' do
        let(:new_attributes) {
          { caption: "This is a new caption" }
        }

        it 'updates the requested post' do
          put :update, params: { id: insta_post.to_param, post: new_attributes }
          insta_post.reload
          expect(insta_post.caption).to eq('This is a new caption')
        end

        it 'redirects to the post' do
          put :update, params: { id: insta_post.to_param, post: new_attributes }
          expect(response).to redirect_to(insta_post)
        end

        it 'redirects to root when user does not own post' do
          new_user = FactoryBot.create(:user, email: "newuser@email.com")
          sign_in(new_user)

          put :update, params: { id: insta_post.to_param, post: new_attributes }
          expect(response).to redirect_to(root_url)
        end

      end

      context 'with invalid params' do
        it "returns a success response" do
          put :update, params: { id: insta_post.to_param, post: invalid_attributes }
          expect(response).to be_success
        end
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'without logged in user' do
      it 'redirects to user login path' do
        delete :destroy, params: { id: insta_post.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context 'With logged in user' do
      before { sign_in(user) }

      it 'destroys the requested post' do
        new_post = FactoryBot.create(:post, user: user) 

        expect {
          delete :destroy, params: { id: new_post.to_param }
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to the posts list' do
        delete :destroy, params: { id: insta_post.to_param }
        expect(response).to redirect_to(posts_url)
      end

      it 'redirects to root when user does not own post' do
          new_user = FactoryBot.create(:user, email: "newuser@email.com")
          sign_in(new_user)

          delete :destroy, params: { id: insta_post.to_param }
          expect(response).to redirect_to(root_url)
        end
    end
  end

end
