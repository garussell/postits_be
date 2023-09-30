require 'rails_helper'

RSpec.describe "Application Controller", type: :request do
  before do
    @user = User.create(username: "test", password: "test")
    post "/login", params: { username: "test", password: "test" }
  end

  describe "decode_token" do
    context "with valid token" do
      it "returns a user" do
        get "/auto_login", headers: { "Authorization" => "Bearer #{token_generator(@user.id)}" }, as: :json

        expect(response).to have_http_status(200)
      end
    end
  end
end