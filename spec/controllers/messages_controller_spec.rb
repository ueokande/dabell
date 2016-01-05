require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  before { sign_in FactoryGirl.create(:user) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:message,
                               user_id: FactoryGirl.create(:user).id)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:message, text: '')
  }

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET #index" do
    it "assigns all messages as @messages" do
      message = Message.create! valid_attributes
      get :index, {}
      expect(assigns(:messages)).to eq([message])
    end
  end

  describe "GET #show" do
    it "assigns the requested message as @message" do
      message = Message.create! valid_attributes
      get :show, {:id => message.to_param}
      expect(assigns(:message)).to eq(message)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, {:message => valid_attributes}
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, {:message => valid_attributes}
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end
    end

    context "with invalid params" do
      it "returns unprocessable_entity" do
        post :create, {:message => invalid_attributes}
        expect(response.status).not_to be(200)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested message" do
      message = Message.create! valid_attributes
      expect {
        delete :destroy, {:id => message.to_param}
      }.to change(Message, :count).by(-1)
    end
  end

end
