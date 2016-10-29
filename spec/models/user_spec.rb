require "rails_helper"

RSpec.describe User do
  describe "macros" do
    it { should have_secure_password }
    it { should accept_nested_attributes_for :root_directory_entry }
  end

  describe "associations" do
    it do
      should have_one(:root_directory_entry).
        conditions(parent_id: nil).
        class_name(DirectoryEntry)
    end
  end

  describe "validations" do
    subject { build(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
