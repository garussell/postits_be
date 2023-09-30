require 'rails_helper'


RSpec.describe "/postits", type: :request do
  before do
    @user = User.create(username: "test", password: "test")
    @postit = Postit.create(title: "test", body: "test", user_id: @user.id)
  end

  let(:valid_attributes) {
    { "title" => "MyString", "body" => "MyText", "user_id" => 1}
  }

  let(:invalid_attributes) {
    { "title" => nil, "body" => nil, "user_id" => nil}
  }

  let(:valid_headers) {
    { "Authorization" => "Bearer #{token_generator(@user.id)}" }
  }

  describe "GET /index" do
    it "renders a successful response" do
    
      get postits_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      
      get postit_path(@postit), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Postit" do
        expect {
          post postits_path,
               params: { postit: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Postit, :count).by(1)
      end

      it "renders a JSON response with the new postit" do
        post postits_path,
             params: { postit: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Postit" do
        expect {
          post postits_path,
               params: { postit: invalid_attributes }, as: :json
        }.to change(Postit, :count).by(0)
      end

      it "renders a JSON response with errors for the new postit" do
        post postits_path,
             params: { postit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { "title" => "MyString", "body" => "MyText", "user_id" => @user.id }
      }

      let(:valid_headers) {
        { "Authorization" => "Bearer #{token_generator(@user.id)}" }
      }

      it "updates the requested postit" do
        
        patch postit_path(@postit),
              params: { postit: new_attributes }, headers: valid_headers, as: :json
  
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the postit" do
        
        patch postit_path(@postit),
              params: { postit: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the postit" do
       
        patch postit_path(@postit),
              params: { postit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested postit" do
      
      expect {
        delete postit_url(@postit), headers: valid_headers, as: :json
      }.to change(Postit, :count).by(-1)
    end
  end
end
