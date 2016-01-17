require 'rails_helper'

RSpec.describe "messages/index", type: :view do
  before { sign_in(FactoryGirl.create(:user)) }

  context 'when message is empty' do
    before do
      assign(:messages, Message.none)
    end
    it 'rendereds successfully' do
      render
    end
  end

  context 'when message is not empty' do
    before do
      5.times do 
        FactoryGirl.create(:message, user: FactoryGirl.create(:user))
      end
      assign(:messages, Message.all)
    end
    it 'rendereds successfully' do
      render
    end
  end
end
