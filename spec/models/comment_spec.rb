require 'rails_helper'

RSpec.describe Comment, type: :model do
 let(:user) { FactoryBot.create(:user) }
 let(:post) { FactoryBot.build(:post, user: user) }
 let(:comment) { post.comments.build(user: user, text: "Comment text")}

 describe 'Validation' do

   it "fails without comment text" do
   	comment.text = ''
   	expect(comment).not_to be_valid
   end

   it "fails without user_id" do
   	comment.user_id = nil
   	expect(comment).not_to be_valid
   end

 end

 describe 'Associations' do
   it { should belong_to(:user) }
 end

end
