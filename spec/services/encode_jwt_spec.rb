require "rails_helper"

RSpec.describe EncodeJwt do
  describe ".perform" do
    let(:user) { create(:user) }

    it "creates an access token" do
      access_token = EncodeJwt.perform(user: user)
      expect(access_token).to be_a String
    end
  end
end
