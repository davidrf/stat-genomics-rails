require "rails_helper"

RSpec.describe "User requests" do
  describe "POST /users" do
    let!(:existing_user) { create(:user) }
    let(:user_attributes) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    context "valid information" do
      let(:user) { build(:user) }

      it "returns a no content response" do
        post(
          users_url,
          headers: accept_header_v1,
          params: user_attributes,
          as: :json
        )

        expect(response).to have_http_status :created
        created_user_id = parsed_body.dig("authentication", "user", "id")
        created_user = User.find(created_user_id)
        expect(response.location).to eq user_url(created_user)
        expect(parsed_body).to match(
          "authentication" => expected_authentication_hash(created_user)
        )
      end
    end

    context "email of already existing user" do
      let(:user) { build(:user, email: existing_user.email) }

      it "returns an unprocessable entity response" do
        post(
          users_url,
          headers: accept_header_v1,
          params: user_attributes,
          as: :json
        )

        expect(response).to have_http_status :unprocessable_entity
        expect(parsed_body).to match(
          "email" => ["has already been taken"]
        )
      end
    end

    context "no email or password" do
      let(:user) { build(:user, email: nil, password: nil) }

      it "returns error messages" do
        post(
          users_url,
          headers: accept_header_v1,
          params: user_attributes,
          as: :json
        )

        expect(response).to have_http_status :unprocessable_entity
        expect(parsed_body).to match(
          "email" => ["can't be blank"],
          "password" => ["can't be blank"]
        )
      end
    end
  end
end
