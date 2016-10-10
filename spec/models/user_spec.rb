require "rails_helper"

RSpec.describe User do
  it { should have_secure_password }

  describe "validations" do
    subject { build(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
