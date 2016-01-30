require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before { sign_in FactoryGirl.create(:user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:attributes) { FactoryGirl.attributes_for(:user) }

    it "returns http success" do
      post :create, { user: attributes }
      expect(response).to redirect_to(users_path)
    end
  end

end
