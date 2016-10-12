require "rails_helper"

RSpec.describe "Authentication requests" do
  describe "POST /authentications" do
    let(:authentication_params) do
      {
        authentication: {
          email: user.email,
          password: user.password
        }
      }
    end

    context "valid information" do
      let(:user) { create(:user) }

      it "returns an ok response" do
        post(
          authentications_url,
          headers: accept_header_v1,
          params: authentication_params,
          as: :json
        )

        expect(response).to have_http_status :ok
        expect(parsed_body).to match(
          "authentication" => expected_authentication_hash(user)
        )
      end
    end

    context "email does not belong to existing user" do
      let(:user) { build(:user, email: "does_not_exist@gmail.com") }

      it "returns a bad request response" do
        post(
          authentications_url,
          headers: accept_header_v1,
          params: authentication_params,
          as: :json
        )

        expect(response).to have_http_status :bad_request
        expect(parsed_body).to match("error" => "invalid_request")
      end
    end

    context "invalid password" do
      let(:existing_user) { create(:user) }
      let(:user) { build(:user, email: existing_user.email, password: "meow1") }

      it "returns a bad request response" do
        post(
          authentications_url,
          headers: accept_header_v1,
          params: authentication_params,
          as: :json
        )

        expect(response).to have_http_status :bad_request
        expect(parsed_body).to match("error" => "invalid_request")
      end
    end
  end
end
