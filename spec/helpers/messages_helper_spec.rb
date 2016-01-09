require 'rails_helper'

RSpec.describe MessagesHelper, type: :helper do
  describe "format" do
    context "when the text contains breaks" do
      subject { format("Hello\nworld") }
      it { should match /br/ }
      it { should match /<div>/ }
    end

    context "when the text contains urls" do
      subject { format("Google on https://google.com/") }
      it { should match /href/ }
      it { should match /<a/ }
    end

    context "when the text contains HTML tags" do
      subject { format("It is <b>fine</b>") }
      it { should_not match /<b>/ }
      it { should match /&lt;b&gt;/ }
    end
  end
end
