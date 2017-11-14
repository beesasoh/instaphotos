require 'rails_helper'

RSpec.describe 'comments/edit', type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      user_id: 1,
      text: 'MyText',
      commentable: nil
    ))
  end

  it 'renders the edit comment form' do
    render

    assert_select 'form[action=?][method=?]', comment_path(@comment), 'post' do

      assert_select 'input[name=?]', 'comment[user_id]'

      assert_select 'textarea[name=?]', 'comment[text]'

      assert_select 'input[name=?]', 'comment[commentable_id]'
    end
  end
end
