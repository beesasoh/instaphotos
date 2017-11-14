FactoryBot.define do
  factory :comment do
    user_id 1
    text 'MyText'
    commentable nil
  end
end
