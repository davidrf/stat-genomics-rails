FactoryGirl.define do
  factory :user, aliases: [:creator] do
    sequence(:email) { |n| "user#{n}@statgenomics.com" }
    password "password1"

    after :create do |user|
      create(:directory_entry, name: "Home Folder", user: user)
    end
  end
end
