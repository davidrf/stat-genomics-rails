FactoryGirl.define do
  factory :directory_entry, aliases: [:parent] do
    sequence(:name) { |n| "Project #{n}" }
    user

    trait :with_folders do
      transient do
        number_of_folders 2
      end

      after(:create) do |directory_entry, evaluator|
        create_list(
          :directory_entry,
          evaluator.number_of_folders,
          user: directory_entry.user,
          parent: directory_entry
        )
      end
    end

    trait :with_files do
      transient do
        number_of_files 2
      end

      after(:create) do |directory_entry, evaluator|
        create_list(
          :file_entry,
          evaluator.number_of_files,
          user: directory_entry.user,
          parent: directory_entry
        )
      end
    end

    trait :with_folder_that_has_files do
      after(:create) do |directory_entry|
        create(
          :directory_entry,
          :with_files,
          user: directory_entry.user,
          parent: directory_entry
        )
      end
    end
  end
end
