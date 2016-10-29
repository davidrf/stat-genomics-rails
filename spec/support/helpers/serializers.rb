module Helpers
  module Serializers
    def expected_user_hash(user)
      {
        "created_at" => user.created_at.as_json,
        "email" => user.email,
        "id" => user.id,
        "updated_at" => user.updated_at.as_json,
        "root_folder_id" => user.root_directory_entry && user.root_directory_entry.id
      }
    end

    def expected_authentication_hash(user)
      {
        "user" => expected_user_hash(user),
        "access_token" => an_instance_of(String)
      }
    end

    def expected_directory_entry_hash_without_associations(directory_entry)
      {
        "created_at" => directory_entry.created_at.as_json,
        "id" => directory_entry.id,
        "name" => directory_entry.name,
        "updated_at" => directory_entry.updated_at.as_json,
      }
    end

    def expected_directory_entry_hash(directory_entry)
      expected_directory_entry_hash_without_associations(directory_entry).merge(
        "user" => expected_user_hash(directory_entry.user),
        "parent" => directory_entry.parent && expected_directory_entry_hash_without_associations(directory_entry.parent),
        "folders" => expected_directory_entries_array(directory_entry.children.directory_entries),
        "files" => expected_file_entries_array(directory_entry.children.file_entries)
      )
    end

    def expected_directory_entries_array(directory_entries)
      directory_entries.map do |directory_entry|
        expected_directory_entry_hash_without_associations(directory_entry)
      end
    end

    def expected_file_entry_hash_without_associations(file_entry)
      {
        "id" => file_entry.id,
        "name" => file_entry.name,
        "created_at" => file_entry.created_at.as_json,
        "updated_at" => file_entry.updated_at.as_json,
      }
    end

    def expected_file_entry_hash(file_entry)
      expected_file_entry_hash_without_associations(file_entry).merge(
        "user" => expected_user_hash(file_entry.user),
        "parent" => expected_file_entry_hash_without_associations(file_entry.parent)
      )
    end

    def expected_file_entries_array(file_entries)
      file_entries.map do |file_entry|
        expected_file_entry_hash_without_associations(file_entry)
      end
    end

    def serialize_model_to_json(model, options = {})
      serializable_resource = ActiveModelSerializers::SerializableResource.new(
        model,
        options
      )
      JSON.parse(serializable_resource.to_json)
    end
  end
end
