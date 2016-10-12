require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  describe "serialization" do
    let(:user) { create(:user) }

    it "should return json with the expected data structure" do
      expect(serialize_model_to_json(user)).to match(
        "user" => expected_user_hash(user)
      )
    end
  end
end
