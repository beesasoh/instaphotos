require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "Associations" do
    it { should have_many(:posts) }
  end
end
