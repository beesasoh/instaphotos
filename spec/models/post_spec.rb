require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'Validations' do
    let(:post) { FactoryGirl.build(:post) }

    it 'does not save without image' do
    	post.should_not be_valid
  		post.errors[:image].should_not be_blank
    end
  end
end
