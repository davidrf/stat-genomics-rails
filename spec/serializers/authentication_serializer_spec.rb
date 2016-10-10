require "rails_helper"

RSpec.describe AuthenticationSerializer, type: :serializer do
  describe "serialization" do
    let(:user) { create(:user) }

    it "should return json with the expected data structure" do
      serialized_model_json = serialize_model_to_json(
        user,
        serializer: AuthenticationSerializer
      )

      expect(serialized_model_json).to match(
        "authentication" => expected_authentication_hash(user)
      )
    end

    it "should create an authentication token using the EncodeJwt service" do
      fake_access_token = "meow"
      allow(EncodeJwt).to receive(:perform) .
        with(user: user).
        and_return(fake_access_token)

      serialized_model_json = serialize_model_to_json(
        user,
        serializer: AuthenticationSerializer
      )
      access_token = serialized_model_json.dig("authentication", "access_token")

      expect(access_token).to eq fake_access_token
    end
  end
end
