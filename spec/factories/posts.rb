FactoryBot.define do
  factory :post do
    caption 'Post caption'
    image { File.new("#{Rails.root}/spec/photos/test.jpg") }
  end
end
