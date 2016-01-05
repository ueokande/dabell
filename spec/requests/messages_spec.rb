require 'rails_helper'

RSpec.describe "Messages", type: :request do

  before { login_as(FactoryGirl.create(:user), scope: :user) }

  describe "GET /messages" do
    it "works! (now write some real specs)" do
      get messages_path, {format: 'json'}
      expect(response).to have_http_status(200)
    end
  end
end
