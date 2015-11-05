require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }

  it { should belong_to(:user) }

  describe "attributes" do
    it "should respond to title" do
      expect(wiki).to respond_to(:title)
    end

    it "should respond to body" do
      expect(wiki).to respond_to(:body)
    end

    it "should respond to private" do
      expect(wiki).to respond_to(:private)
    end
  end
end