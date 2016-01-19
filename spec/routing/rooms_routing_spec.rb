require "rails_helper"

RSpec.describe MessagesController, type: :routing do
  describe "routing" do
    it "routes to #show by root path" do
      expect(:get => "/").to route_to("rooms#show")
    end
  end
end
