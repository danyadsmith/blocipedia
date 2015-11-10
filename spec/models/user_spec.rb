require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "attributes" do
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
  end
end
