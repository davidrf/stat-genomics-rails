require "rails_helper"

RSpec.describe EncodeJwt do
  describe ".perform" do
    let(:user) { create(:user) }
    let(:access_token) { EncodeJwt.perform(user: user) }
    let(:access_token_duration_in_days) do
      ENV.fetch("ACCESS_TOKEN_DURATION_IN_DAYS", "7").to_i
    end

    context "valid access token" do
      it "returns the access token payload" do
        allow(Time).to receive(:current).and_return(Time.current)
        payload = DecodeJwt.perform(access_token: access_token)
        expect(payload).to match(
          "sub" => user.id,
          "exp" => access_token_duration_in_days.days.from_now.to_i
        )
      end
    end

    context "expired token access token" do
      it "raises an error" do
        allow(Time).to receive(:current).and_return(
          access_token_duration_in_days.days.ago,
          Time.current
        )
        expect do
          DecodeJwt.perform(access_token: access_token)
        end.to raise_error JWT::ExpiredSignature
      end
    end
  end
end
