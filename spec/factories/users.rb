FactoryGirl.define do
  factory :user, aliases: [:creator] do
    sequence(:email) { |n| "user#{n}@statgenomics.com" }
    password "password1"
  end
end
