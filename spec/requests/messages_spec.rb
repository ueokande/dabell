require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  context 'when user is logged in' do
    before { login_as(FactoryGirl.create(:user), scope: :user) }

    describe 'GET /messages' do
      it 'returns success' do
        get messages_path,
            params: { format: 'json' }
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'when user is not logged in' do
    describe 'GET /messages' do
      it 'returns Unauthorized' do
        get messages_path,
            params: { format: 'json' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
