FactoryGirl.define do
  factory :file_entry do
    sequence(:name) { |n| "File #{n}" }
    parent
    user
  end
end
