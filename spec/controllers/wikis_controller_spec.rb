require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki, private: false, user: my_user) }
  let(:my_private_wiki) { create(:wiki, private: true, user: my_user) }

  context "guest" do
  end

  context "standard user" do
    before do
      sign_in my_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki, my_private_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end
  end
end
