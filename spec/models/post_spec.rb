require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post, user: user) }

  describe 'Validation' do
  	
    it "fails with no user_id" do
    	post.user_id = nil
    	expect(post).not_to be_valid
  	end

  	it "fails with no image" do
    	post.image = nil
    	expect(post).not_to be_valid
  	end

    it 'Saves with correct attributes' do
    	expect(post).to be_valid
    end

    it 'Saves without caption' do
    	post.caption = nil
    	expect(post).to be_valid
    end
  end

  describe 'Association' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

end
