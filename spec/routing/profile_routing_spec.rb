require 'rails_helper'

RSpec.describe ProfileController, type: :routing do
  describe 'routing' do
  
    it 'routes to #show' do
      expect(get: '/beesasoh').to route_to('profile#show', user_name: 'beesasoh')
    end

  end
end
