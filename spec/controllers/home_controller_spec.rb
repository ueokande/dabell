require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  before { sign_in FactoryGirl.create(:user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
