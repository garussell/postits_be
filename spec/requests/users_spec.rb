require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "creates a new user" do
      post "/users", params: { username: "test", password: "test" }

      expect(response).to have_http_status(200)
      expect(response.content_type).to match(a_string_including("application/json"))
      
    end

    it "sad path: does not create a new user" do
      post "/users", params: { username: "test" }

      expect(response).to have_http_status(401)
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  describe "POST /login" do
    before do
      User.create(username: "test", password: "test")
    end

    it "logs in a user" do
      post "/login", params: { username: "test", password: "test" }

      expect(response).to have_http_status(200)
      expect(response.content_type).to match(a_string_including("application/json"))
    end

    it "sad path: does not log in a user" do
      post "/login", params: { username: "test", password: "wrong" }

      expect(response).to have_http_status(401)
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  describe "GET /auto_login" do
    before do
      @user = User.create(username: "test", password: "test")
      post "/login", params: { username: "test", password: "test" }
    end

    let(:valid_headers) {
        { "Authorization" => "Bearer #{token_generator(@user.id)}" }
      }

    it "auto logs in a user" do
      get "/auto_login", headers: valid_headers, as: :json 

      expect(response).to have_http_status(200)
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end
end
