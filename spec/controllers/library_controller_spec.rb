require 'rails_helper'

RSpec.describe LibraryController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

	describe 'GET #search' do
		it 'returns list of results for given query' do
			get :search, {search: 'Song title'}
			expect(assigns(:results))
		end
	end

end
