require "rails_helper"

RSpec.describe FileEntry do
  describe "associations" do
    it { should belong_to(:parent).class_name(DirectoryEntry) }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:parent) }
    it { should validate_presence_of(:user) }
  end
end
