require 'rails_helper'

RSpec.describe "Messages", type: :request do

  context 'when user is logged in' do
    before { login_as(FactoryGirl.create(:user), scope: :user) }

    describe "GET /" do
      it "return success" do
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'when user is not logged in' do
    describe "GET /" do
      it "redirects to authenticate page" do
        get root_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
