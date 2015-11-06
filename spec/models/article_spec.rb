require 'rails_helper'
include RandomData

RSpec.describe Article, type: :model do
  let(:wiki) { create(:wiki) }
  let(:article) { create(:article, wiki: wiki) }

  it { should belong_to(:wiki) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe "attributes" do
    it "should respond to title" do
      expect(article).to respond_to(:title)
    end

    it "should respond to body" do
      expect(article).to respond_to(:body)
    end
  end
end

