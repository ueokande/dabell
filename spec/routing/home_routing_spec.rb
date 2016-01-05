require "rails_helper"

RSpec.describe MessagesController, type: :routing do
  describe "routing" do

    it "routes to #index by root_path" do
      expect(:get => "/").to route_to("home#index")
    end
  end
end
